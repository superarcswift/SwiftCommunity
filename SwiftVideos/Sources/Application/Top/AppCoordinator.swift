//
//  Copyright © 2019 An Tran. All rights reserved.
//

import XCoordinator
import SuperArcCoreUI
import SuperArcCore
import RxSwift
import UIKit

class AppCoordinator: NavigationCoordinator<AppRoute> {

    // MARK: Properties

    private let viewControllerContext: ViewControllerContext

    // MARK: Initialization

    init(viewControllerContext: ViewControllerContext) {
        self.viewControllerContext = viewControllerContext
        super.init(initialRoute: .dashboard)
    }

    // MARK: Overrides

    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        case .dashboard:
            let viewController = DashboardViewController.instantiate()
            viewController.setViewControllerContext(viewControllerContext)
            let viewModel = DashboardViewModel(router: anyRouter, engine: viewControllerContext.engine)
            viewController.storedViewModel = viewModel

            return .push(viewController)
        }
    }
}

enum AppRoute: Route {
    case dashboard
}
