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
        featureAComponent = FeatureAComponent(dependency: self, context: context)
        featureBComponent = FeatureBComponent(dependency: self, context: context)

        let dashboardViewController = DashboardViewController.instantiate(with: context.viewControllerContext)
        dashboardViewController.viewControllers = [
            featureAComponent.makeFeatureAViewController().viewController,
            featureBComponent.makeFeatureBViewController().viewController
        ]

        return dashboardViewController
    }
}

extension DashboardComponent: FeatureADependency {}

extension DashboardComponent: FeatureBDependency {}
