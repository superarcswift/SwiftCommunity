//
//  Copyright © 2019 An Tran. All rights reserved.
//

import FeatureB
import SuperArcCoreComponent
import SuperArcCore

class FeatureBComponentRouter: FeatureBComponentRouterProtocol {

    // MARK: Properties

    var context: ApplicationContextProtocol

    lazy var componentsRouter: ComponentsRouter = {
        self.context.viewControllerContext.resolve(type: ComponentsRouter.self)
    }()

    // MARK: Initialization

    init(context: ApplicationContextProtocol) {
        self.context = context
    }

    // MARK: APIs

    func trigger(_ route: FeatureBComponentRoute) -> ComponentPresentable? {
        switch route {
        case .featureA:
            return componentsRouter.featureAInterface.show(dependency: componentsRouter, componentsRouter: componentsRouter.featureARouter, hasRightCloseButton: true)
        case .featureC:
            return componentsRouter.featureCInterface.show(dependency: componentsRouter, hasRightCloseButton: true)
        case .featureD:
            return componentsRouter.featureDInterface.show(dependency: componentsRouter)
        }
    }

}
