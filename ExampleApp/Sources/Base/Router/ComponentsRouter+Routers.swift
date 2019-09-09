//
//  Copyright © 2019 An Tran. All rights reserved.
//

import FeatureA
import SuperArcCoreComponent

extension ComponentsRouter: HasFeatureAComponentRouter {

    public var featureARouter: AnyComponentRouter<FeatureAComponentRoute> {
        return routerRegistry.resolve(type: FeatureAComponentRouter.self).anyFeatureARouter
    }
}

extension ComponentsRouter: HasFeatureBComponentRouter {

    public var featureBRouter: AnyComponentRouter<FeatureBComponentRoute> {
        return routerRegistry.resolve(type: FeatureBComponentRouter.self).anyFeatureBRouter
    }
}
