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

    private let context: ApplicationContext
    private let onboardingCoordinator: OnboardingCoordinator

    // MARK: Initialization

    init(context: ApplicationContext) {
        self.context = context
        onboardingCoordinator = OnboardingCoordinator(context: context)
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

extension AppCoordinator: OnboardingDependency {}
