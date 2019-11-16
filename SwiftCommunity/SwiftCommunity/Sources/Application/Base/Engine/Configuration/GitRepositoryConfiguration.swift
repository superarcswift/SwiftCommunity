//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import SuperArcFoundation

struct GitRepositoryConfiguration: GitRepositoryConfigurationProtocol {

    // MARK: Properties

    var endpoint: Endpoint

    // MARK: Initialization

    init(endpoint: Endpoint) {
        self.endpoint = endpoint
    }

    // MARK: APIs

    var url: URL {
        return URL(string: "https://github.com/superarcswift/SwiftCommunityContent")!
    }
}
