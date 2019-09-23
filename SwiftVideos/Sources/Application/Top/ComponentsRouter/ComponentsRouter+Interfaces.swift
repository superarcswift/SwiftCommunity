//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Videos
import Authors
import SuperArcCoreComponent

extension ComponentsRouter {

    var videosInterface: VideosInterface {
        return interfaceRegistry.resolveOnDemand(type: VideosInterface.self)
    }

    var authorsInterface: AuthorsInterface {
        return interfaceRegistry.resolveOnDemand(type: AuthorsInterface.self)
    }
}
