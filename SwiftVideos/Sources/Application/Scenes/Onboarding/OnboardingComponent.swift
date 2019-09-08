//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import XCoordinator

/// Protocol defining all dependencies required by this component.
typealias OnboardingDependency = HasGitService

/// Protocol used to mock for testing purpose.
protocol OnboardingViewBuilder: ViewBuildable {
    func makeOnboardingViewController(router: AnyRouter<OnboardingRoute>) -> OnboardingViewController
}

class OnboardingComponent: Component<OnboardingDependency, OnboardingViewBuilder, EmptyInterface, EmptyComponentRoute>, OnboardingViewBuilder {

    // MARK: APIs

    func makeOnboardingViewController(router: AnyRouter<OnboardingRoute>) -> OnboardingViewController {
        let viewController = OnboardingViewController.instantiate(with: context.viewControllerContext)
        let viewModel = OnboardingViewModel(router: router, dependency: dependency)
        viewController.viewModel = viewModel

        return viewController
    }
}
