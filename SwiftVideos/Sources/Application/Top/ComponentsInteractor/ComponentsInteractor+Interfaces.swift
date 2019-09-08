//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Videos
import Authors

extension ComponentsRouter {

    var videosInterface: VideosInterfaceProtocol {
        return interfaceRegistry.resolve(type: VideosInterfaceProtocol.self)
    }

    var authorsInterface: AuthorsInterfaceProtocol {
        return interfaceRegistry.resolve(type: AuthorsInterfaceProtocol.self)
    }
}
