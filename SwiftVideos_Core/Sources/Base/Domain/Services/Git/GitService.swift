//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore
import SuperArcFoundation
import PromiseKit
import ObjectiveGit
import Foundation

public protocol HasGitService {
    var gitService: GitServiceProtocol { get }
}

public protocol GitServiceProtocol {

    var baseLocalRepositoryPath: String { get }
    var localRepository: GTRepository? { get set }

    func open() -> Bool

    /// Clone the content repository to disk.
    /// - Returns: Promise<Void>
    func clone(progressHandler: @escaping (Float, Bool) -> Void) -> Promise<Void>

    func update() -> Promise<Void>

    func reset() -> Promise<Bool>
}

public class GitService: Service, GitServiceProtocol {

    // MARK: Properties

    // Static

    public let baseLocalRepositoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    public lazy var baseContentPath = {
        return baseLocalRepositoryPath.combinePath("content")
    }()

    // Public

    public var context: ServiceContext

    public var localRepository: GTRepository?

    // Private

    // TODO: This should be come from configuration.
    private let repositoryURL = "https://github.com/superarcswift/SwiftVideosContent"

    private lazy var localRepositoryURL = URL(string: "file://\(baseLocalRepositoryPath)/")! // This needs to be prefix with file://

    private let fileManager = FileManager.default

    private let queue: DispatchQueue

    // MARK: Initialization

    public init(context: ServiceContext) {
        self.context = context
        queue = DispatchQueue(label: "com.tba.swiftvideos.gitservice", qos: .userInitiated)
        print(baseLocalRepositoryPath)
    }

    // MARK: APIs

    /// Prepare the repository on local disk for displaying content.
    /// - Returns: bool
    public func open() -> Bool {

        guard FileManager.default.fileExists(atPath: baseLocalRepositoryPath) else {
            return false
        }

        // Check if local repository is available
        do {
            localRepository = try GTRepository(url: localRepositoryURL)
        } catch {
            return false
        }

        return true
    }

    /// Clone the content repository to disk.
    /// - Returns: Promise<Void>
    public func clone(progressHandler: @escaping (Float, Bool) -> Void) -> Promise<Void> {
        return Promise { resolver in
            guard let remoteRepositoryURL = URL(string: repositoryURL) else {
                return resolver.reject(GitServiceError.invalidURL)
            }

            queue.async {
                do {
                    self.localRepository = try GTRepository.clone(from: remoteRepositoryURL, toWorkingDirectory: self.localRepositoryURL, options: [GTRepositoryCloneOptionsTransportFlags: true], transferProgressBlock: { progress, isFinished in
                        let progress = Float(progress.pointee.received_objects)/Float(progress.pointee.total_objects)
                        progressHandler(progress, isFinished.pointee.boolValue)
                    })
                    DispatchQueue.main.async {
                        resolver.fulfill(())
                    }
                } catch {
                    DispatchQueue.main.async {
                        resolver.reject(error)
                    }
                }
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

            queue.async {
                do {
                    let branch = try localRepository.currentBranch()
                    let remoteRepository = try GTRemote(name: "origin", in: localRepository)
                    try localRepository.pull(branch, from: remoteRepository, withOptions: nil, progress: nil)
                    DispatchQueue.main.async {
                        resolver.fulfill(())
                    }
                } catch {
                    DispatchQueue.main.async {
                        resolver.reject(error)
                    }
                }
            }
        }
    }

    /// Remove the local repository folder.
    /// - Returns: true or false
    public func reset() -> Promise<Bool> {
        return Promise { resolver in
            guard fileManager.fileExists(atPath: baseLocalRepositoryPath) else {
                return resolver.fulfill(false)
            }

            queue.async {
                do {
                    try self.fileManager.removeItem(atPath: self.baseLocalRepositoryPath)
                    DispatchQueue.main.async {
                        resolver.fulfill(true)
                    }
                } catch {
                    DispatchQueue.main.async {
                        resolver.reject(error)
                    }
                }
            }
        }
    }

    // MARK: Private helpers
}

enum GitServiceError: Error {
    case invalidURL
    case noLocalRepository
}
