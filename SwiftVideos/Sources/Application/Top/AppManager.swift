//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SwiftVideos_Core
import SuperArcActivityIndicator
import SuperArcNotificationBanner
import SuperArcCore

class AppManager {

    // MARK: Properties

    // Public

    lazy var core: Core = {
        return Core()
    }()

    // MARK: Intialization

    init() {
        setupServices()
        setupApplicationContext()
    }

    // MARK: Private helpers

    private func setupApplicationContext() {
        core.context.viewControllerContext.register(NotificationPresenter(), for: NotificationPresenter.self)
        core.context.viewControllerContext.register(ActivityPresenter(), for: ActivityPresenter.self)
    }

    private func setupServices() {
        let gitService = GitService(context: core.engine.serviceContext)
        core.engine.serviceRegistry.register(gitService, for: GitService.self)

        let videosContentProvider = FilesystemVideosContentProvider(rootContentFolderPath: gitService.baseContentPath)
        let videosService = VideosService(context: core.engine.serviceContext, contentProvider: videosContentProvider)
        core.engine.serviceRegistry.register(videosService, for: VideosService.self)

        let authorsContentProvider = FilesystemAuthorsContentProvider(rootContentFolderPath: gitService.baseContentPath)
        let authorsService = AuthorsService(context: core.engine.serviceContext, contentProvider: authorsContentProvider)
        core.engine.serviceRegistry.register(authorsService, for: AuthorsService.self)

        let conferencesContentProvider = FilesystemConferencesContentProvider(rootContentFolderPath: gitService.baseContentPath)
        let conferencesService = ConferencesService(context: core.engine.serviceContext, contentProvider: conferencesContentProvider, videosService: videosService)
        core.engine.serviceRegistry.register(conferencesService, for: ConferencesService.self)
    }
}
