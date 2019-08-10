//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import XCoordinator

/// Protocol defining all dependencies required by this component..
typealias OnboardingDependency = Dependency & HasGitService

/// Protocol used to mock for testing purpose.
protocol OnboardingBuilder {
    func makeOnboardingViewController(router: AnyRouter<OnboardingRoute>) -> OnboardingViewController
}

class OnboardingComponent: Component<OnboardingDependency>, OnboardingBuilder {

    // MARK: APIs

    func makeOnboardingViewController(router: AnyRouter<OnboardingRoute>) -> OnboardingViewController {
        let viewController = OnboardingViewController.instantiate(with: context)
        let viewModel = OnboardingViewModel(router: router, dependency: dependency, engine: context.engine)
        viewController.storedViewModel = viewModel

        return viewController
    }
}
