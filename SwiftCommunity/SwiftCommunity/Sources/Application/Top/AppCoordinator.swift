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

    private let component: AppComponent
    lazy private var onboardingCoordinator = OnboardingCoordinator(dependency: component, context: self.component.context)

    // MARK: Initialization

    init(context: ApplicationContextProtocol) {
        component = AppComponent(dependency: EmptyComponent(), viewControllerContext: context.viewControllerContext, context: context)
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
