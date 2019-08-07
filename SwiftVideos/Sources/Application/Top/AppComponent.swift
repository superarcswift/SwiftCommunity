//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCore
import SuperArcFoundation

class AppComponent: Component<EmptyDependency> {

    // MARK: Properties

    // Public

    lazy public var coordinator = AppCoordinator(context: context)

    // MARK: APIs

    func setRoot(for window: UIWindow) {
        coordinator.anyRouter.setRoot(for: window)
    }
}
