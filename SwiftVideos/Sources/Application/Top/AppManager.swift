//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore

class AppManager {

    // MARK: Properties

    // Public

    lazy var core: Core = {
        return Core()
    }()

    // Private

    // MARK: Intialization

    init() {
        let conferencesService = ConferencesService(context: core.engine.serviceContext, contentProvider: FilesystemConferencesContentProvider())
        core.engine.serviceRegistry.register(conferencesService, for: ConferencesService.self)

        let videosService = VideosService(context: core.engine.serviceContext, contentProvider: FilesystemVideosContentProvider())
        core.engine.serviceRegistry.register(videosService, for: VideosService.self)

        let authorsService = AuthorsService(context: core.engine.serviceContext, contentProvider: FilesystemAuthorsContentProvider())
        core.engine.serviceRegistry.register(authorsService, for: AuthorsService.self)
    }
}
