//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import DataModels
import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import XCoordinator

// MARK: - VideosComponent

class VideosComponent: Component<VideosDependency, VideosViewBuilder, VideosInterfaceProtocol, VideosComponentRoute>, VideosViewBuilder {

    // MARK: APIs

    func makeVideosCollectionViewController(conferenceMetaData: ConferenceMetaData?, conferenceEdition: ConferenceEdition?, router: UnownedRouter<VideosRoute>) -> VideosCollectionViewController {

        let viewController = VideosCollectionViewController.instantiate(with: viewControllerContext)
        if conferenceMetaData != nil {
            viewController.hasLeftCloseButton = true
        }
        let viewModel = VideosCollectionViewModel(router: router, dependency: dependency, conferenceMetaData: conferenceMetaData, conferenceEdition: conferenceEdition)
        viewController.viewModel = viewModel

        return viewController
    }

    func makeVideoDetailViewController(videoMetaData: VideoMetaData, hasLeftCloseButton: Bool, router: UnownedRouter<VideosRoute>) -> VideoDetailViewController {
        let viewController = VideoDetailViewController.instantiate(with: viewControllerContext)
        viewController.videosComponent = self
        let viewModel = VideoDetailViewModel(router: router, dependency: dependency, videoMetaData: videoMetaData)
        viewController.viewModel = viewModel
        viewController.hasLeftCloseButton = hasLeftCloseButton

        return viewController
    }

        override func trigger(_ route: VideosComponentRoute) -> ComponentPresentable? {
        return router?.trigger(route)
    }
}

// MARK: - VideosViewBuilder

protocol VideosViewBuilder: ViewBuildable {
    func makeVideosCollectionViewController(conferenceMetaData: ConferenceMetaData?, conferenceEdition: ConferenceEdition?, router: UnownedRouter<VideosRoute>) -> VideosCollectionViewController
    func makeVideoDetailViewController(videoMetaData: VideoMetaData, hasLeftCloseButton: Bool, router: UnownedRouter<VideosRoute>) -> VideoDetailViewController
}

// MARK: - VideosInterface

public class VideosInterface: VideosInterfaceProtocol {

    // MARK: Properties

    private weak var navigator: Navigator!
    public weak var dependencyProvider: DependencyProvider!
    public weak var viewControllerContext: ViewControllerContext!

    // MARK: Initialization

    public required init(onDemandWith componentsRouter: Navigator, viewControllerContext: ViewControllerContext, and dependencyProvider: DependencyProvider) {
        self.navigator = componentsRouter
        self.viewControllerContext = viewControllerContext
        self.dependencyProvider = dependencyProvider
    }

    // MARK: APIs

    public func showVideo(conferenceMetaData: ConferenceMetaData, conferenceEdition: ConferenceEdition, dependency: VideosDependency, router: AnyComponentRouter<VideosComponentRoute>) -> Presentable {
        return VideosCoordinator(
            initialRoute: .videos(conferenceMetaData, conferenceEdition),
            navigator: navigator,
            depedency: dependency,
            router: router,
            viewControllerContext: viewControllerContext,
            dependencyProvider: dependencyProvider)
    }

    public func showVideo(videoMetaData: VideoMetaData, dependency: VideosDependency, router: AnyComponentRouter<VideosComponentRoute>) -> Presentable {
        return VideosCoordinator(
            initialRoute: .videoDetail(videoMetaData, true),
            navigator: navigator,
            depedency: dependency,
            router: router,
            viewControllerContext: viewControllerContext,
            dependencyProvider: dependencyProvider)
    }

}

// MARK: - VideosComponentRouter

public protocol VideosComponentRouterProtocol: ComponentRouter, ComponentRouterIdentifiable where ComponentRouteType == VideosComponentRoute {}

extension VideosComponentRouterProtocol where ComponentRouteType == VideosComponentRoute {

    public var anyVideosRouter: AnyComponentRouter<VideosComponentRoute> {
        return AnyComponentRouter(self)
    }
}

public enum VideosComponentRoute: ComponentRoute {
    case author(AuthorMetaData)
}
