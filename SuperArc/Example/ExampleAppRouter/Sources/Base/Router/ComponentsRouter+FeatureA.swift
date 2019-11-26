//
//  Copyright © 2019 An Tran. All rights reserved.
//

import FeatureA
import SuperArcCoreComponent
import SuperArcCore

class FeatureAComponentRouter: FeatureAComponentRouterProtocol {

    // MARK: Properties

    var context: ApplicationContextProtocol

    lazy var navigator: Navigator = {
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
            return navigator.featureBInterface.show(dependency: navigator, router: navigator.featureBRouter, hasRightCloseButton: true)
        case .featureC:
            return navigator.featureCInterface.show(dependency: navigator, hasRightCloseButton: true)
        case .featureD:
            return navigator.featureDInterface.show(dependency: navigator)
        }
    }

}
