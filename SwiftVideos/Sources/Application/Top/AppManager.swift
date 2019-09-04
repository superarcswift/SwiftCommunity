//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Conferences
import Videos
import Authors

import Core
import DataModels

import SuperArcActivityIndicator
import SuperArcNotificationBanner
import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation

import XCoordinator

class AppManager: HasNavigationDelegateManager {

    // MARK: Properties

    // Public

    lazy var core: Core = {
        return Core()
    }()

    // Private

    lazy var navigationDelegateManager: NavigationDelegateManagerProtocol = NavigationDelegateManager(context: core.context)

    // MARK: Intialization

    init() {
        setupServices()
        setupApplicationContext()
        setupNavigationDelegate()
    }

    // MARK: Private helpers

    private func setupApplicationContext() {
        core.context.viewControllerContext.register(NotificationPresenter(), for: NotificationPresenter.self)
        core.context.viewControllerContext.register(ActivityPresenter(), for: ActivityPresenter.self)
    }

    private func setupServices() {
        let gitService = GitService(context: core.engine.serviceContext)
        core.engine.serviceRegistry.register(gitService, for: GitServiceProtocol.self)

        let videosContentProvider = FilesystemVideosContentProvider(rootContentFolderPath: gitService.baseContentPath)
        let videosService = VideosService(context: core.engine.serviceContext, contentProvider: videosContentProvider)
        core.engine.serviceRegistry.register(videosService, for: VideosServiceProtocol.self)

        let authorsContentProvider = FilesystemAuthorsContentProvider(rootContentFolderPath: gitService.baseContentPath)
        let authorsService = AuthorsService(context: core.engine.serviceContext, contentProvider: authorsContentProvider)
        core.engine.serviceRegistry.register(authorsService, for: AuthorsServiceProtocol.self)

        let conferencesContentProvider = FilesystemConferencesContentProvider(rootContentFolderPath: gitService.baseContentPath)
        let conferencesService = ConferencesService(context: core.engine.serviceContext, contentProvider: conferencesContentProvider, videosService: videosService)
        core.engine.serviceRegistry.register(conferencesService, for: ConferencesServiceProtocol.self)
    }

    private func setupNavigationDelegate() {
        core.context.viewControllerContext.register(navigationDelegateManager, for: NavigationDelegateManagerProtocol.self)
        navigationDelegateManager.interfaceRegistry.register(VideosInterface(), for: VideosInterfaceProtocol.self)
    }
}
