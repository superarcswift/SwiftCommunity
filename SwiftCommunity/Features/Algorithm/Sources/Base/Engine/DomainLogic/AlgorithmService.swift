//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import SuperArcCore
import SuperArcFoundation
import PromiseKit

// MARK: - Protocol

protocol HasAlgorithmService {
    var algorithmService: AlgorithmService { get }
}

protocol AlgorithmServiceProtocol {
    func fetchSection(with sectionID: String?) -> Promise<Section>
}

// MARK: - Implementation

class AlgorithmService: BaseGitService, AlgorithmServiceProtocol {

    // MARK: Properties

    // Static

    static let baseRemoteRepositoryURL = "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master"

    // Private

    private var root: Section?

    // MARK: Initialization

    public convenience init(context: ServiceContext) {
        let repositoryURL = try! context.configurations.container.resolve(GitRepositoryConfigurationProtocol.self).algorithmRepositoryURL
        self.init(context: context, remoteRepositoryURL: repositoryURL)
    }

    // MARK: APIs

    func fetchSection(with sectionID: String?) -> Promise<Section> {
        guard let sectionID = sectionID else {
            return withRoot()
        }

        return withRoot().then { section -> Promise<Section> in
            guard let section = section.search(for: sectionID) else {
                throw AlgorithmServiceError.sectionNotFound
            }

            return Promise.value(section)
        }
    }

    func loadContent(from path: String) -> Promise<String?> {
        return Promises.asyncOnGlobalQueue {

            guard let fileURL = self.localURL(for: path) else {
                throw AlgorithmServiceError.invalidPath
            }

            let data = try Data(contentsOf: fileURL)
            let markdown = String(data: data, encoding: .utf8)
            return self.processImages(in: markdown, for: path)
        }
    }

    // MARK: Private helpers

    private func fetchData() -> Promise<Section> {
        return Promises.asyncOnGlobalQueue {
            let jsonURL = Bundle(for: AlgorithmService.self).url(forResource: "index", withExtension: "json")!
            let data = try Data(contentsOf: jsonURL)
            let section = try JSONDecoder().decode(Section.self, from: data)
            return section
        }
    }

    private func withRoot() -> Promise<(Section)> {
        if let root = root {
            return Promise.value(root)
        }

        return fetchData()
    }

    private func processImages(in markdown: String?, for sectionPath: String) -> String? {
        guard let string = markdown else {
            return nil
        }

        let baseRemotePath = AlgorithmService.baseRemoteRepositoryURL.combinePath(sectionPath.basePath)

        let regex = try! NSRegularExpression(pattern: "(!\\[[^\\]]*\\])\\(((?!http).*?)\\)")
        let range = NSRange(location: 0, length: string.count)
        let newString = regex.stringByReplacingMatches(in: string, options: [], range: range, withTemplate: "$1(\(baseRemotePath)/$2)")
        return newString
    }
}

// MARK: - Error

enum AlgorithmServiceError: Error {
    case sectionNotFound
    case invalidPath
}
