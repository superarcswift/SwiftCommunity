//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation

public class ComponentsRouter: ComponentsRouterProtocol {

    // MARK: Properties

    // Private

    public var context: ApplicationContextProtocol!

    public let interfaceRegistry: InterfaceRegistry
    public let routerRegistry: RouterRegistry

    // MARK: Setup

    public init(context: ApplicationContextProtocol) {
        self.context = context
        interfaceRegistry = InterfaceRegistry(context: context)
        routerRegistry = RouterRegistry()
    }

    // MARK: APIs

    public func register<T: Interface>(_ instance: T, for type: T.Type) {
        interfaceRegistry.register(instance, for: type)
    }

    public func register<T: ComponentRouterIdentifiable>(_ instance: T, for type: T.Type) {
        routerRegistry.register(instance, for: type)
    }
}
