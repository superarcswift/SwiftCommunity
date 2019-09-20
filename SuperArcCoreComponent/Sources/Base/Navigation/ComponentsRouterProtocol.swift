//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore
import SuperArcFoundation

/// Main protocol responsible for handling routing between components.
public protocol ComponentsRouterProtocol: HasApplicationContext {
    var interfaceRegistry: InterfaceRegistry { get }
    var routerRegistry: RouterRegistry { get }
}

public protocol HasComponentsRouter {
    // Note: This variable has a concrete type since we are going to add more dependencies into it via extension.
    var componentsRouter: ComponentsRouter { get }
}

public class InterfaceRegistry: Registry {

    // MARK: Properties

    public var container: Container<Interface>

    // MARK: Initialization

    public init() {
        container = Container()
    }
}

public class RouterRegistry: Registry {

    // MARK: Properties

    public var container: Container<ComponentRouterIdentifiable>

    // MARK: Initialization

    public init() {
        container = Container()
    }
}
