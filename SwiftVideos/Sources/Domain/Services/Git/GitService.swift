//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore
import SuperArcFoundation
import PromiseKit
import ObjectiveGit
import Foundation

protocol HasGitService {
    var gitService: GitService { get }
}

protocol GitServiceProtocol {

    var baseLocalRepositoryPath: String { get }
    var localRepository: GTRepository? { get set }

    func open() -> Bool

    /// Clone the content repository to disk.
    /// - Returns: Promise<Void>
    func clone() -> Promise<Void>

    func update() -> Promise<Void>

    func remove() -> Bool
}

public class GitService: Service, GitServiceProtocol {

    // MARK: Properties

    // Public

    public var context: ServiceContext

    var localRepository: GTRepository?

    let baseLocalRepositoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!.combinePath("content")

    // Private

    // TODO: This should be come from configuration.
    let repositoryURL = "https://github.com/peacemoon/SwiftVideosContent"

    lazy var localRepositoryURL = URL(string: "file://\(baseLocalRepositoryPath)/")! // This needs to be prefix with file://

    private let fileManager = FileManager.default
    
    // MARK: Initialization

    init(context: ServiceContext) {
        self.context = context

        print(baseLocalRepositoryPath)
    }

    // MARK: APIs

    /// Prepare the repository on local disk for displaying content.
    /// - Result: bool
    public func open() -> Bool {

        guard FileManager.default.fileExists(atPath: baseLocalRepositoryPath) else {
            return false
        }

        // Check if local repository is available
        do {
            localRepository = try GTRepository(url: localRepositoryURL)
        } catch {
            print(error)
            return false
        }

        return true
    }

    /// Clone the content repository to disk.
    /// - Returns: Promise<Void>
    public func clone() -> Promise<Void> {
        return Promise { resolver in
            guard let remoteRepositoryURL = URL(string: repositoryURL) else {
                return resolver.reject(GitServiceError.invalidURL)
            }

            do {
                localRepository = try GTRepository.clone(from: remoteRepositoryURL, toWorkingDirectory: localRepositoryURL, options: [GTRepositoryCloneOptionsTransportFlags: true], transferProgressBlock: nil)
                resolver.fulfill(())
            } catch {
                resolver.reject(error)
            }
        }
    }

    /// Pull update of the remote repository to disk.
    /// - Returns: Promise<Void>
    public func update() -> Promise<Void> {
        return Promise { resolver in
            guard let localRepository = localRepository else {
                resolver.reject(GitServiceError.noLocalRepository)
                return
            }

            do {
                let branch = try localRepository.currentBranch()
                let remoteRepository = try GTRemote(name: "origin", in: localRepository)
                try localRepository.pull(branch, from: remoteRepository, withOptions: nil, progress: nil)
                resolver.fulfill(())
            } catch {
                resolver.reject(error)
            }
        }
    }

    /// Remove the local repository folder.
    /// - Returns: true or false
    public func remove() -> Bool {
        guard fileManager.fileExists(atPath: baseLocalRepositoryPath) else {
            return false
        }

        do {
            try fileManager.removeItem(atPath: baseLocalRepositoryPath)
            return true
        } catch {
            print(error)
            return false
        }
    }

    // MARK: Private helpers
}

enum GitServiceError: Error {
    case invalidURL
    case noLocalRepository
}
