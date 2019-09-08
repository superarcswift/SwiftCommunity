//
//  Copyright © 2019 An Tran. All rights reserved.
//

import CoreUX
import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation

class ComponentsRouter: ComponentsRouterProtocol {

    // MARK: Properties

    // Private

    internal var context: ApplicationContextProtocol!
    internal var interfaceRegistry = InterfaceRegistry()
    internal var routerRegistry = RouterRegistry()

    // MARK: Setup

    init(context: ApplicationContextProtocol) {
        self.context = context
    }

    // MARK: APIs

    func register<T: Interface>(_ instance: T, for type: T.Type) {
        interfaceRegistry.register(instance, for: type)
    }

    func register<T: ComponentRouterIdentifiable>(_ instance: T, for type: T.Type) {
        routerRegistry.register(instance, for: type)
    }
}
