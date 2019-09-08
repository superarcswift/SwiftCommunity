//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import SuperArcCoreComponent
import SuperArcCore

// MARK: - Dependencies

extension ComponentsRouter: HasVideosService {

    public var videosService: VideosServiceProtocol {
        return context.engine.serviceRegistry.resolve(type: VideosServiceProtocol.self)
    }
}

extension ComponentsRouter: HasAuthorsService {

    public var authorsService: AuthorsServiceProtocol {
        return context.engine.serviceRegistry.resolve(type: AuthorsServiceProtocol.self)
    }
}
