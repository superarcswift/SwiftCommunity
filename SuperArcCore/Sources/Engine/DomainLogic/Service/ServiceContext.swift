//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcNetwork
import SuperArcFoundation

public protocol ServiceContextProtocol {}

public class ServiceContext: ServiceContextProtocol {

    // MARK: Properties

    // Public

    public let endpoint: Endpoint
    public let configurations: AnyRegistry<Configuration>
    public let communicationInterfaces = Container<CommunicationInterface>()

    // MARK: Initialization

    public init(endpoint: Endpoint, configurations: AnyRegistry<Configuration>) {
        self.endpoint = endpoint
        self.configurations = configurations
    }

    // MARK: CommunicationInterface

    public func register<T: CommunicationInterface>(_ communicationInterface: T, for type: T.Type) {
        try! communicationInterfaces.register(communicationInterface, for: type)
    }

    public func communicationInterface<T: CommunicationInterface>(typed type: T.Type) -> T? {
        return communicationInterfaces.resolve(type)
    }
}
