//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore
import SuperArcFoundation

class ConfigurationsRegistry: Registry {

    // MARK: Properties

    // Internal

    var container: Container<Configuration>

    // Private

    private var endpoint: Endpoint

    // MARK: Initialization

    init(endpoint: Endpoint) {
        self.endpoint = endpoint
        container = Container()

        setup()
    }

    // MARK: Private helpers

    private func setup() {
        // register any new type of configuration here
    }
}
