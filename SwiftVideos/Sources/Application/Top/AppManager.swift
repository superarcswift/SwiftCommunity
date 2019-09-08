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

class AppManager: HasComponentsInteractor, HasConfigurations {

    // MARK: Properties

    // Public

    lazy var core: Core = {
        return Core(configurations: configurations)
    }()

    // Private

    lazy internal var componentsInteractor: ComponentsRouterProtocol = ComponentsRouter(context: core.context)
    lazy internal var configurations = AnyRegistry(ConfigurationsRegistry(endpoint: .current))

    // MARK: Intialization

    init() {
        setupServices()
        setupApplicationContext()
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
        core.context.viewControllerContext.register(componentsInteractor, for: ComponentsRouterProtocol.self)

        componentsInteractor.interfaceRegistry.register(VideosInterface(), for: VideosInterfaceProtocol.self)
        componentsInteractor.interfaceRegistry.register(AuthorsInterface(), for: AuthorsInterfaceProtocol.self)

        componentsInteractor.routerRegistry.register(ConferencesComponentRouter(context: core.context), for: ConferencesComponentRouter.self)
        componentsInteractor.routerRegistry.register(VideosComponentRouter(context: core.context), for: VideosComponentRouter.self)
        componentsInteractor.routerRegistry.register(AuthorsComponentRouter(context: core.context), for: AuthorsComponentRouter.self)
    }
}
