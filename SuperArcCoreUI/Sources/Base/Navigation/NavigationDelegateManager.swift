//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore
import SuperArcFoundation

public protocol ModuleInterface {}

public protocol NavigationDelegateManagerProtocol: HasApplicationContext {}

public protocol HasNavigationDelegateManager {
    var navigationDelegateManager: NavigationDelegateManagerProtocol { get }
}
