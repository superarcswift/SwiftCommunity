//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation

public protocol HasConfigurations {
    var configurations: AnyRegistry<Configuration> { get }
}

open class ConfigurationsRegistry: Registry {

    // MARK: Properties

    // Public

    public var container: Container<Configuration>

    // Private

    private var endpoint: Endpoint

    // MARK: Initialization

    public init(endpoint: Endpoint) {
        self.endpoint = endpoint
        container = Container()

        setup()
    }

    // MARK: Private helpers

    open func setup() {
        // pre-register any new type of configuration here
    }
}
