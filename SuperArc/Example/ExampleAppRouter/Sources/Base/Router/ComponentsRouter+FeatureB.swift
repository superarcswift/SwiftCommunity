//
//  Copyright © 2019 An Tran. All rights reserved.
//

import FeatureB
import SuperArcCoreComponent
import SuperArcCore

class FeatureBComponentRouter: FeatureBComponentRouterProtocol {

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

    func trigger(_ route: FeatureBComponentRoute) -> ComponentPresentable? {
        switch route {
        case .featureA:
            return navigator.featureAInterface.show(dependency: navigator, router: navigator.featureARouter, hasRightCloseButton: true)
        case .featureC:
            return navigator.featureCInterface.show(dependency: navigator, hasRightCloseButton: true)
        case .featureD:
            return navigator.featureDInterface.show(dependency: navigator)
        }
    }

}
