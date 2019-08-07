//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import XCoordinator

class OnboardingCoordinator: NavigationCoordinator<OnboardingRoute> {

    // MARK: Properties

    private var context: ApplicationContext

    // MARK: Initialization

    init(context: ApplicationContext) {
        self.context = context
        super.init(initialRoute: .onboarding)
    }

    // MARK: Overrides

    override func prepareTransition(for route: OnboardingRoute) -> NavigationTransition {
        switch route {

        case .onboarding:
            let viewController = OnboardingViewController.instantiate(with: context)
            let viewModel = OnboardingViewModel(router: anyRouter, engine: context.engine)
            viewController.storedViewModel = viewModel
            return .push(viewController)

        case .dashboard:
            let dashboardCoordinator = DashboardCoordinator(context: context)
            return .present(dashboardCoordinator, animation: .fade)
        }
    }
}

enum OnboardingRoute: Route {
    case onboarding
    case dashboard
}
