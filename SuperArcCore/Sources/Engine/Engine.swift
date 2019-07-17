//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

public protocol EngineProtocol {
    var serviceContext: ServiceContext { get }
    var serviceRegistry: ServiceRegistry { get }
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
