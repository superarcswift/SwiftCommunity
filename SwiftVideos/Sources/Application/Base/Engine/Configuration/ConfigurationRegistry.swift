//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import SuperArcCore
import SuperArcFoundation

// Move this to SuperArcCore as standard ConfigurationsRegistry.
public class ConfigurationsRegistry: Registry {

    // MARK: Properties

    // Internal

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

    private func setup() {
        register(GitRepositoryConfiguration(endpoint: endpoint), for: GitRepositoryConfigurationProtocol.self)
    }
}
