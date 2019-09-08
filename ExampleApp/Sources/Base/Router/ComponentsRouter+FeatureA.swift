//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCore
import XCoordinator

class FeatureAComponentRouter: FeatureAComponentRouterProtocol {

    var context: ApplicationContextProtocol

    lazy var componentsRouter: ComponentsRouter = {
        // TODO: See if we can remove this force cast
        self.context.viewControllerContext.resolve(type: ComponentsRouterProtocol.self) as! ComponentsRouter
    }()

    init(context: ApplicationContextProtocol) {
        self.context = context
    }

    func trigger(_ route: FeatureAComponentRoute) -> ComponentPresentable {
        switch route {
        case .featureB:
            return componentsRouter.featureBInterface.show(dependency: componentsRouter, componentsRouter: componentsRouter.featureBRouter, context: context, hasRightCloseButton: true)
        case .featureC:
            return componentsRouter.featureCInterface.show(dependency: componentsRouter, context: context, hasRightCloseButton: true)
        case .featureD:
            return componentsRouter.featureDInterface.show(dependency: componentsRouter, context: context)
        }
    }
    
}
