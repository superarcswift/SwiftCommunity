//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import XCoordinator

typealias OnboardingDependency = HasConferencesGitService

protocol OnboardingViewBuilder: ViewBuildable {
    func makeOnboardingViewController(router: UnownedRouter<OnboardingRoute>) -> OnboardingViewController
}

class OnboardingComponent: Component<OnboardingDependency, OnboardingViewBuilder, EmptyInterface, EmptyComponentRoute>, OnboardingViewBuilder {

    // MARK: APIs

    func makeOnboardingViewController(router: UnownedRouter<OnboardingRoute>) -> OnboardingViewController {
        let viewController = OnboardingViewController.instantiate(with: viewControllerContext)
        let viewModel = OnboardingViewModel(router: router, dependency: dependency)
        viewController.viewModel = viewModel

        return viewController
    }
}
