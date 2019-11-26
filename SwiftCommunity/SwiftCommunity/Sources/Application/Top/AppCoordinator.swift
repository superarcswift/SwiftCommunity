//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import XCoordinator
import RxSwift
import UIKit

class AppCoordinator: NavigationCoordinator<AppRoute> {

    // MARK: Properties

    // Private

    private let navigator: Navigator
    private let component: AppComponent

    lazy private var onboardingCoordinator = OnboardingCoordinator(navigator: navigator,
                                                                   dependency: component,
                                                                   viewControllerContext: component.viewControllerContext,
                                                                   dependencyProvider: component.dependencyProvider)

    // MARK: Initialization

    init(navigator: Navigator, viewControllerContext: ViewControllerContext, dependencyProvider: DependencyProvider) {
        self.navigator = navigator
        component = AppComponent(dependency: EmptyComponent(),
                                 viewControllerContext: viewControllerContext,
                                 dependencyProvider: dependencyProvider)
        super.init(initialRoute: .onboarding)
    }

    // MARK: Overrides

    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        case .onboarding:
            return .presentFullScreen(onboardingCoordinator)
        }
    }
}

enum AppRoute: Route {
    case onboarding
}
