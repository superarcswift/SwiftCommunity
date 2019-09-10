//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation

// Move this into SuperArcComponent as standard ComponentsRouter
public class ComponentsRouter: ComponentsRouterProtocol {

    // MARK: Properties

    // Private

    public var context: ApplicationContextProtocol!

    public var interfaceRegistry = InterfaceRegistry()
    public var routerRegistry = RouterRegistry()

    // MARK: Setup

    public init(context: ApplicationContextProtocol) {
        self.context = context
    }

    // MARK: APIs

    public func register<T: Interface>(_ instance: T, for type: T.Type) {
        interfaceRegistry.register(instance, for: type)
    }

    public func register<T: ComponentRouterIdentifiable>(_ instance: T, for type: T.Type) {
        routerRegistry.register(instance, for: type)
    }
}
