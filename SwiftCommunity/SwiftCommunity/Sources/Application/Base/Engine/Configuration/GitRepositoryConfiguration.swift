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

    var conferencesRepositoryURL: URL {
        return URL(string: "https://github.com/superarcswift/SwiftCommunityContent")!
    }

    var algorithmRepositoryURL: URL {
        return URL(string: "https://github.com/raywenderlich/swift-algorithm-club")!
    }

}
