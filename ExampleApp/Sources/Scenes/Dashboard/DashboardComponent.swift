//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCoreUI

protocol DashboardComponentBuilder: ViewBuildable {
    func makeDashboardViewController() -> DashboardViewController
}

class DashboardComponent: Component<EmptyDependency, DashboardComponentBuilder, EmptyInterface, EmptyComponentRoute>, DashboardComponentBuilder {

    var featureAComponent: FeatureAComponent!
    var featureBComponent: FeatureBComponent!

    func makeDashboardViewController() -> DashboardViewController {
        let componentsRouter = context.viewControllerContext.resolve(type: ComponentsRouterProtocol.self) as! ComponentsRouter
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
