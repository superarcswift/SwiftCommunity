//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import XCoordinator

/// Protocol defining all dependencies required by this component..
protocol OnboardingDependency: Dependency {}

/// Protocol used to mock for testing purpose.
protocol OnboardingBuilder {
    var coordinator: OnboardingCoordinator { get }
    static func makeOnboardingViewController(context: ApplicationContext, router: AnyRouter<OnboardingRoute>) -> OnboardingViewController
}

class OnboardingComponent: Component<OnboardingDependency>, OnboardingBuilder {

    // MARK: Properties

    // Public

    lazy public var coordinator = OnboardingCoordinator(context: context)

    // MARK: APIs

    static func makeOnboardingViewController(context: ApplicationContext, router: AnyRouter<OnboardingRoute>) -> OnboardingViewController {
        let viewController = OnboardingViewController.instantiate(with: context)
        let viewModel = OnboardingViewModel(router: router, engine: context.engine)
        viewController.storedViewModel = viewModel

        return viewController
    }
}
