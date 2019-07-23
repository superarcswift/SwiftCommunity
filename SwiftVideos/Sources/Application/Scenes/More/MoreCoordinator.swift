//
//  Copyright © 2019 An Tran. All rights reserved.
//

import XCoordinator
import SuperArcCoreUI
import SuperArcCore
import RxSwift

class MoreCoordinator: NavigationCoordinator<MoreRoute> {

    // MARK: Properties

    // Private

    private var viewControllerContext: ViewControllerContext

    // MARK: Initialization

    init(viewControllerContext: ViewControllerContext) {
        self.viewControllerContext = viewControllerContext
        super.init(initialRoute: .list)
    }

    // MARK: Overrides

    override func prepareTransition(for route: MoreRoute) -> NavigationTransition {
        switch route {
        case .list:
            let viewController = MoreTableViewController.instantiate()
            return .push(viewController)

        case .close:
            return .dismissToRoot()
        }
    }

}

enum MoreRoute: Route {
    case list
    case close
}
