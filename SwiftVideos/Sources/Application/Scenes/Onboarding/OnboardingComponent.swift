//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import XCoordinator

protocol OnboardingDependency: Dependency {
}

protocol OnboardingComponent {
    static func makeOnboardingCoordinator(viewControllerContext: ViewControllerContext) -> OnboardingCoordinator
    static func makeOnboardingViewController(viewControllerContext: ViewControllerContext, router: AnyRouter<OnboardingRoute>) -> OnboardingViewController
}

struct StandardOnboardingComponent: OnboardingComponent {

    static func makeOnboardingCoordinator(viewControllerContext: ViewControllerContext) -> OnboardingCoordinator {
        return OnboardingCoordinator(viewControllerContext: viewControllerContext)
    }
    
    static func makeOnboardingViewController(viewControllerContext: ViewControllerContext, router: AnyRouter<OnboardingRoute>) -> OnboardingViewController {
        let viewController = OnboardingViewController.instantiate(with: viewControllerContext)
        let viewModel = OnboardingViewModel(router: router, engine: viewControllerContext.engine)
        viewController.storedViewModel = viewModel

        return viewController
    }
}
