//
//  Copyright © 2019 An Tran. All rights reserved.
//

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
        featureAComponent = FeatureAComponent(dependency: self, viewControllerContext: viewControllerContext, dependencyProvider: dependencyProvider)
        featureBComponent = FeatureBComponent(dependency: self, viewControllerContext: viewControllerContext, dependencyProvider: dependencyProvider)

        let dashboardViewController = DashboardViewController.instantiate(with: viewControllerContext)
        dashboardViewController.viewControllers = [
            featureAComponent.makeFeatureAViewController().viewController,
            featureBComponent.makeFeatureBViewController().viewController
        ]

        return dashboardViewController
    }
}

extension DashboardComponent: FeatureADependency {}

extension DashboardComponent: FeatureBDependency {}
