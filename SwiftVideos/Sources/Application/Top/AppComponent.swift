//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore
import SuperArcFoundation

class AppComponent: Component<EmptyDependency>, HasViewControllerContext {

    // MARK: Properties

    // Public

    lazy public var coordinator = AppCoordinator(viewControllerContext: context)

    public var context: ViewControllerContext!

    // MARK: Initialization

    init(viewControllerContext: ViewControllerContext) {
        self.context = viewControllerContext
        super.init(dependency: EmptyComponent())
    }

    // MARK: APIs

    func setRoot(for window: UIWindow) {
        coordinator.anyRouter.setRoot(for: window)
    }
}
