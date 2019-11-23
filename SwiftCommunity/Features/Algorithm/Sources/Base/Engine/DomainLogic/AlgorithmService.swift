//
//  Copyright © 2019 An Tran. All rights reserved.
//

import PromiseKit
import SuperArcCore

// MARK: - Protocol

protocol AlgorithmServiceProtocol {
    func fetchData() -> Promise<Section>
}

// MARK: - Implementation

class AlgorithmService: Service, AlgorithmServiceProtocol {

    // MARK: Properties

    var context: ServiceContext

    // MARK: Initialization

    init(context: ServiceContext) {
        self.context = context
    }

    // MARK: APIs

    func fetchData() -> Promise<Section> {
        return Promise { resolver in
            let jsonURL = Bundle(for: AlgorithmService.self).url(forResource: "index", withExtension: "json")!
            let data = try Data(contentsOf: jsonURL)
            let section = try JSONDecoder().decode(Section.self, from: data)
            resolver.fulfill(section)
        }
    }

}
