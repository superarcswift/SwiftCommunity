//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Algorithm
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

class AppManager: HasConfigurations {

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

    lazy internal var navigator: Navigator = Navigator(context: core.context)
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
        let gitService = ConferencesGitService(context: core.context.engine.serviceContext)
        core.context.engine.serviceRegistry.register(gitService, for: ConferencesGitServiceProtocol.self)

        let videosContentProvider = FilesystemVideosContentProvider(rootContentFolderPath: gitService.baseContentPath)
        let videosService = VideosService(context: core.context.engine.serviceContext, contentProvider: videosContentProvider)
        core.context.engine.serviceRegistry.register(videosService, for: VideosServiceProtocol.self)

        let authorsContentProvider = FilesystemAuthorsContentProvider(rootContentFolderPath: gitService.baseContentPath)
        let authorsService = AuthorsService(context: core.context.engine.serviceContext, contentProvider: authorsContentProvider)
        core.context.engine.serviceRegistry.register(authorsService, for: AuthorsServiceProtocol.self)

        let conferencesContentProvider = FilesystemConferencesContentProvider(rootContentFolderPath: gitService.baseContentPath)
        let conferencesService = ConferencesService(context: core.context.engine.serviceContext, contentProvider: conferencesContentProvider, videosService: videosService)
        core.context.engine.serviceRegistry.register(conferencesService, for: ConferencesServiceProtocol.self)
    }

    private func setupComponentsCoordinator() {
        // Register interfaces
        VideosCoordinator.register(to: core.context, navigator: navigator, dependencyProvider: core)
        AuthorsCoordinator.register(to: core.context, navigator: navigator, dependencyProvider: core)

        // Register routers
        navigator.routerRegistry.register(ConferencesComponentRouter(navigator: navigator, context: core.context), for: ConferencesComponentRouter.self)
        navigator.routerRegistry.register(VideosComponentRouter(navigator: navigator, context: core.context), for: VideosComponentRouter.self)
        navigator.routerRegistry.register(AuthorsComponentRouter(navigator: navigator, context: core.context), for: AuthorsComponentRouter.self)
    }

    private func setupCommunicationInterfaces() {
        let server = DirectAccessJSONServer(configurationContainer: configurations.container)
        core.context.engine.serviceContext.register(server, for: DirectAccessJSONServer.self)
    }
}

extension Core: DependencyProvider {}
