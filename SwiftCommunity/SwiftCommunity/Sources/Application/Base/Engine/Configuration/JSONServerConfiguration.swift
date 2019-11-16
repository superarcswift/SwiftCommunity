//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcNetwork
import SuperArcFoundation

struct OpenConferenceConfiguration: ServerConfiguration {

    // MARK: Properties

    let endpoint: Endpoint

    // MARK: Initialization

    init(endpoint: Endpoint) {
        self.endpoint = endpoint
    }

    var baseURL: URL {
        return URL(string: "https://raw.githubusercontent.com/tech-conferences/conference-data/master/conferences/")!
    }

}
