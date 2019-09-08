//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation

public protocol ServiceContextProtocol {}

public class ServiceContext: ServiceContextProtocol {

    // MARK: Properties

    public let endpoint: Endpoint
    public let configurations: AnyRegistry<Configuration>

    // MARK: Initialization

    public init(endpoint: Endpoint, configurations: AnyRegistry<Configuration>) {
        self.endpoint = endpoint
        self.configurations = configurations
    }
}
