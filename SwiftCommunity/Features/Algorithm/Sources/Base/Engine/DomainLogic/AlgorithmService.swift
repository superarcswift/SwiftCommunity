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

    var root: Section?

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
            return String(data: data, encoding: .utf8)
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
}

// MARK: - Error

enum AlgorithmServiceError: Error {
    case sectionNotFound
    case invalidPath
}
