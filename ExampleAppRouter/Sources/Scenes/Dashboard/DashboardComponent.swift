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
        let componentsRouter = context.viewControllerContext.resolve(type: ComponentsRouter.self)
        featureAComponent = FeatureAComponent(dependency: componentsRouter, componentsRouter: componentsRouter.featureARouter, context: context)
        featureBComponent = FeatureBComponent(dependency: componentsRouter, componentsRouter: componentsRouter.featureBRouter, context: context)

        let dashboardViewController = DashboardViewController.instantiate(with: context.viewControllerContext)
        dashboardViewController.viewControllers = [
            featureAComponent.makeFeatureAViewController().viewController,
            featureBComponent.makeFeatureBViewController().viewController
        ]

        return dashboardViewController
    }
}
