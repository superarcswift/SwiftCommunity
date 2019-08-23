//
//  Copyright © 2019 An Tran. All rights reserved.
//

/// Protocol defining required dependencies used for processing business logic.
/// Normally, a component only needs a subset of objects in engine to fullfill his dependency requirement.
public protocol EngineProtocol {
    var serviceContext: ServiceContext { get }
    var serviceRegistry: ServiceRegistry { get }
}

public protocol HasEngine {
    var engine: Engine { get set }
}

public class Engine: EngineProtocol {

    // MARK: Properties

    public let serviceContext: ServiceContext

    public let serviceRegistry = ServiceRegistry()

    // MARK: Initialization

    public init(serviceContext: ServiceContext) {
        self.serviceContext = serviceContext
    }
}
