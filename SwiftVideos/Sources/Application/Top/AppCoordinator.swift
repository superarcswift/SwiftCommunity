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
    private let onboardingCoordinator: OnboardingCoordinator

    // MARK: Initialization

    init(viewControllerContext: ViewControllerContext) {
        self.viewControllerContext = viewControllerContext
        onboardingCoordinator = OnboardingCoordinator(viewControllerContext: viewControllerContext)
        super.init(initialRoute: .onboarding)
    }

    // MARK: Overrides

    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        case .onboarding:
            return .present(onboardingCoordinator)
        }
    }
}

enum AppRoute: Route {
    case onboarding
}
