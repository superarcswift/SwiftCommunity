//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Conferences
import Videos
import Authors
import SuperArcCoreComponent

extension ComponentsRouter {

    var conferencesRouter: AnyComponentRouter<ConferencesComponentRoute> {
        return routerRegistry.resolve(type: ConferencesComponentRouterProtocol.self).anyConferencesRouter
    }

    var videosRouter: AnyComponentRouter<VideosComponentRoute> {
        return routerRegistry.resolve(type: VideosComponentRouterProtocol.self).anyVideosRouter
    }

    var authorsRouter: AnyComponentRouter<AuthorsComponentRoute> {
        return routerRegistry.resolve(type: AuthorsComponentRouterProtocol.self).anyAuthorsRouter
    }
}
