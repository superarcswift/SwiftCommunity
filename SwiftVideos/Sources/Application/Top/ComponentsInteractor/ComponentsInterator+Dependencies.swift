//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import SuperArcCore

// MARK: - Dependencies

extension ComponentsRouter: HasVideosService {

    var videosService: VideosServiceProtocol {
        return context.engine.serviceRegistry.resolve(type: VideosServiceProtocol.self)
    }
}

extension ComponentsRouter: HasAuthorsService {

    var authorsService: AuthorsServiceProtocol {
        return context.engine.serviceRegistry.resolve(type: AuthorsServiceProtocol.self)
    }
}
