//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore
import SuperArcFoundation

public class NavigationDelegateManager: HasApplicationContext {

    // MARK: Properties

    public var context: ApplicationContext!

    // MARK: Setup

    public init(context: ApplicationContext) {
        self.context = context
    }
}

public protocol HasNavigationDelegateManager {
    var navigationDelegateManager: NavigationDelegateManager { get }
}
