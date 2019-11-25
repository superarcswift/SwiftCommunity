//
//  Copyright © 2019 An Tran. All rights reserved.
//

import FeatureA
import SuperArcCoreComponent
import SuperArcCore

class FeatureAComponentRouter: FeatureAComponentRouterProtocol {

    // MARK: Properties

    var context: ApplicationContextProtocol

    lazy var componentsRouter: Navigator = {
        self.context.viewControllerContext.resolve(type: Navigator.self)
    }()

    // MARK: Initialization

    init(context: ApplicationContextProtocol) {
        self.context = context
    }

    // MARK: APIs

    func trigger(_ route: FeatureAComponentRoute) -> ComponentPresentable? {
        switch route {
        case .featureB:
            return componentsRouter.featureBInterface.show(dependency: componentsRouter, componentsRouter: componentsRouter.featureBRouter, hasRightCloseButton: true)
        case .featureC:
            return componentsRouter.featureCInterface.show(dependency: componentsRouter, hasRightCloseButton: true)
        case .featureD:
            return componentsRouter.featureDInterface.show(dependency: componentsRouter)
        }
    }

}
