//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation

/// The main application router which is responsible to navigate between the components.
public class Navigator: NavigatorProtocol, DependencyProvider {

    // MARK: Properties

    // Private

    public weak var context: ApplicationContextProtocol!

    public let interfaceRegistry: InterfaceRegistry
    public let routerRegistry: RouterRegistry

    // MARK: Setup

    public init(context: ApplicationContextProtocol) {
        self.context = context
        routerRegistry = RouterRegistry()
        interfaceRegistry = InterfaceRegistry(viewControllerContext: context.viewControllerContext)
        interfaceRegistry.navigator = self
        interfaceRegistry.dependencyProvider = self
    }

    // MARK: APIs

    public func register<T: Interface>(_ instance: T, for type: T.Type) {
        interfaceRegistry.register(instance, for: type)
    }

    public func register<T: ComponentRouterIdentifiable>(_ instance: T, for type: T.Type) {
        routerRegistry.register(instance, for: type)
    }
}
