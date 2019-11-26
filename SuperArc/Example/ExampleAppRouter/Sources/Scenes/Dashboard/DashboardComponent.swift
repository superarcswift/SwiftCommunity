//
//  Copyright © 2019 An Tran. All rights reserved.
//

import FeatureA
import FeatureB
import SuperArcCoreComponent
import SuperArcCoreUI

// MARK: - DashboardComponentBuilder

protocol DashboardComponentBuilder: ViewBuildable {
    func makeDashboardViewController() -> DashboardViewController
}

// MARK: - DashboardComponent

class DashboardComponent: Component<EmptyDependency, DashboardComponentBuilder, EmptyInterface, EmptyComponentRoute>, DashboardComponentBuilder {

    // MARK: Properties

    var featureAComponent: FeatureAComponent!
    var featureBComponent: FeatureBComponent!

    // MARK: APIs

    func makeDashboardViewController() -> DashboardViewController {
        let navigator = viewControllerContext.resolve(type: Navigator.self)
        featureAComponent = FeatureAComponent(dependency: navigator, router: navigator.featureARouter, viewControllerContext: viewControllerContext, dependencyProvider: dependencyProvider)
        featureBComponent = FeatureBComponent(dependency: navigator, router:  navigator.featureBRouter, viewControllerContext: viewControllerContext, dependencyProvider: dependencyProvider)

        let dashboardViewController = DashboardViewController.instantiate(with: viewControllerContext)
        dashboardViewController.viewControllers = [
            featureAComponent.makeFeatureAViewController().viewController,
            featureBComponent.makeFeatureBViewController().viewController
        ]

        return dashboardViewController
    }
}
