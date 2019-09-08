//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent

extension ComponentsRouter {

    var featureARouter: AnyComponentRouter<FeatureAComponentRoute> {
        return routerRegistry.resolve(type: FeatureAComponentRouter.self).anyFeatureARouter
    }

    var featureBRouter: AnyComponentRouter<FeatureBComponentRoute> {
        return routerRegistry.resolve(type: FeatureBComponentRouter.self).anyFeatureBRouter
    }
}
