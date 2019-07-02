//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

public protocol Engine {
    var serviceContext: ServiceContext { get }
    var serviceAssembly: ServiceAssembly { get }
}

public class StandardEngine: Engine {

    // MARK: Properties

    public let serviceContext: ServiceContext

    public let serviceAssembly = ServiceAssembly()

    // MARK: Initialization

    public init(serviceContext: ServiceContext) {
        self.serviceContext = serviceContext
    }
}
