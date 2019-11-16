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
import SuperArcNetwork
import SuperArcFoundation

import XCoordinator

class AppManager: HasComponentsRouter, HasConfigurations {

    // MARK: Properties

    // Public

    lazy var core: Core = {
        #if DEBUG
        let endpoint: Endpoint = .development
        #else
        let endpoint: Endpoint = .production
        #endif
        return Core(endpoint: endpoint, configurations: configurations)
    }()

    // Private

    lazy internal var componentsRouter: ComponentsRouter = ComponentsRouter(context: core.context)
    lazy internal var configurations = AnyRegistry(ConfigurationsRegistry(endpoint: .current))

    // MARK: Intialization

    init() {
        setupServices()
        setupApplicationContext()
        setupCommunicationInterfaces()
        setupComponentsCoordinator()
    }

    // MARK: Private helpers

    private func setupApplicationContext() {
        core.context.viewControllerContext.register(NotificationPresenter(), for: NotificationPresenter.self)
        core.context.viewControllerContext.register(ActivityPresenter(), for: ActivityPresenter.self)
    }

    private func setupServices() {
        let remoteRepositoryURL = try! configurations.container.resolve(GitRepositoryConfigurationProtocol.self).url
        let gitService = GitService(context: core.engine.serviceContext, remoteRepositoryURL: remoteRepositoryURL)
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

    private func setupComponentsCoordinator() {
        core.context.viewControllerContext.register(componentsRouter, for: ComponentsRouter.self)

        VideosCoordinator.register(to: core.context)
        AuthorsCoordinator.register(to: core.context)

        componentsRouter.routerRegistry.register(ConferencesComponentRouter(context: core.context), for: ConferencesComponentRouter.self)
        componentsRouter.routerRegistry.register(VideosComponentRouter(context: core.context), for: VideosComponentRouter.self)
        componentsRouter.routerRegistry.register(AuthorsComponentRouter(context: core.context), for: AuthorsComponentRouter.self)
    }

    private func setupCommunicationInterfaces() {
        let server = DirectAccessJSONServer(configurationContainer: configurations.container)
        core.context.engine.serviceContext.register(server, for: DirectAccessJSONServer.self)
    }
}
