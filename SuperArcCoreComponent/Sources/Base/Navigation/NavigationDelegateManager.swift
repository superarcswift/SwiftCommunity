//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore
import SuperArcFoundation

public protocol NavigationDelegateManagerProtocol: HasApplicationContext {
    var interfaceRegistry: InterfaceRegistry { get }
    var delegateRegistry: NavigationDelegateRegistry { get }
}

public protocol HasNavigationDelegateManager {
    var navigationDelegateManager: NavigationDelegateManagerProtocol { get }
}

public class NavigationDelegateRegistry: Registry {

    // MARK: Properties

    public var container: Container<NavigationDelegate>

    // MARK: Initialization

    public init() {
        container = Container()
    }
}

public class InterfaceRegistry: Registry {

    // MARK: Properties

    public var container: Container<Interface>

    // MARK: Initialization

    public init() {
        container = Container()
    }
}
