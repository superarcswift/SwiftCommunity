//
//  Copyright © 2019 An Tran. All rights reserved.
//

import FeatureB
import SuperArcCoreComponent
import SuperArcCore
import XCoordinator

class FeatureBComponentRouter: FeatureBComponentRouterProtocol {

    var context: ApplicationContextProtocol

    lazy var componentsRouter: ComponentsRouter = {
        // TODO: See if we can remove this force cast
        self.context.viewControllerContext.resolve(type: ComponentsRouterProtocol.self) as! ComponentsRouter
    }()

    init(context: ApplicationContextProtocol) {
        self.context = context
    }

    func trigger(_ route: FeatureBComponentRoute) -> ComponentPresentable {
        switch route {
        case .featureA:
            return componentsRouter.featureAInterface.show(dependency: componentsRouter, componentsRouter: componentsRouter.featureARouter, context: context, hasRightCloseButton: true)
        case .featureC:
            return componentsRouter.featureCInterface.show(dependency: componentsRouter, context: context, hasRightCloseButton: true)
        case .featureD:
            return componentsRouter.featureDInterface.show(dependency: componentsRouter, context: context)
        }
    }

}
