//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import XCoordinator

class OnboardingCoordinator: NavigationCoordinator<OnboardingRoute> {

    // MARK: Properties

    // Private

    private let componentsRouter: Navigator
    private let component: OnboardingComponent

    // MARK: Initialization

    init(componentsRouter: Navigator,
         dependency: OnboardingDependency,
         viewControllerContext: ViewControllerContext,
         dependencyProvider: DependencyProvider) {
        self.componentsRouter = componentsRouter
        component = OnboardingComponent(dependency: dependency, viewControllerContext: viewControllerContext, dependencyProvider: dependencyProvider)
        super.init(initialRoute: .onboarding)
    }

    // MARK: Overrides

    override func prepareTransition(for route: OnboardingRoute) -> NavigationTransition {
        switch route {

        case .onboarding:
            let viewController = component.viewBuilder.makeOnboardingViewController(router: unownedRouter)
            return .push(viewController)

        case .dashboard:
            let dashboardCoordinator = DashboardCoordinator(componentsRouter: componentsRouter, viewControllerContext: component.viewControllerContext, dependencyProvider: component.dependencyProvider)
            return .presentFullScreen(dashboardCoordinator, animation: .fade)
        }
    }
}

enum OnboardingRoute: Route {
    case onboarding
    case dashboard
}
