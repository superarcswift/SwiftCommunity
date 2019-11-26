//
//  Copyright © 2019 An Tran. All rights reserved.
//

import FeatureA
import FeatureB
import SuperArcCoreComponent

extension Navigator: HasFeatureAComponentRouter {

    public var featureARouter: AnyComponentRouter<FeatureAComponentRoute> {
        return routerRegistry.resolve(type: FeatureAComponentRouter.self).anyFeatureARouter
    }
}

extension Navigator: HasFeatureBComponentRouter {

    public var featureBRouter: AnyComponentRouter<FeatureBComponentRoute> {
        return routerRegistry.resolve(type: FeatureBComponentRouter.self).anyFeatureBRouter
    }
}
