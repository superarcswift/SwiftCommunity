//
//  Copyright © 2019 An Tran. All rights reserved.
//

import PromiseKit
import SuperArcCore
import SuperArcFoundation

// MARK: - Protocol

protocol AlgorithmServiceProtocol {
    func fetchSection(with sectionID: String?) -> Promise<Section>
}

// MARK: - Implementation

class AlgorithmService: Service, AlgorithmServiceProtocol {

    // MARK: Properties

    // Static

    static let baseRemoteRepositoryURL = "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master"

    var context: ServiceContext

    var root: Section?

    // MARK: Initialization

    init(context: ServiceContext) {
        self.context = context
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

enum AlgorithmServiceError: Error {
    case sectionNotFound
    case invalidPath
}
