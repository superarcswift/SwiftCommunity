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
    //private let dashboardCoordinator: DashboardCoordinator
    private let onboardingCoordinator: OnboardingCoordinator

    // MARK: Initialization

    init(viewControllerContext: ViewControllerContext) {
        self.viewControllerContext = viewControllerContext
        //dashboardCoordinator = DashboardCoordinator(viewControllerContext: viewControllerContext)
        //super.init(initialRoute: .dashboard)

        onboardingCoordinator = OnboardingCoordinator(viewControllerContext: viewControllerContext)
        super.init(initialRoute: .onboarding)
    }

    // MARK: Overrides

    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
//        case .dashboard:
//            return .present(dashboardCoordinator)
        case .onboarding:
            return .present(onboardingCoordinator)
        }
    }
}

enum AppRoute: Route {
//    case dashboard
    case onboarding
}
