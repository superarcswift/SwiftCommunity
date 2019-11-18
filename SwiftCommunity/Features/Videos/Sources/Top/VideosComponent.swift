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
        return componentsRouter?.trigger(route)
    }
}

// MARK: - VideosViewBuilder

protocol VideosViewBuilder: ViewBuildable {
    func makeVideosCollectionViewController(conferenceMetaData: ConferenceMetaData?, conferenceEdition: ConferenceEdition?, router: UnownedRouter<VideosRoute>) -> VideosCollectionViewController
    func makeVideoDetailViewController(videoMetaData: VideoMetaData, hasLeftCloseButton: Bool, router: UnownedRouter<VideosRoute>) -> VideoDetailViewController
}

// MARK: - VideosInterface

public class VideosInterface: VideosInterfaceProtocol, OnDemandInterface {

    public weak var dependencyProvider: DependencyProvider!

    // MARK: Initialization

    public required init(onDemandWith dependencyProvider: DependencyProvider) {
        self.dependencyProvider = dependencyProvider
    }

    // MARK: APIs

    public func showVideo(conferenceMetaData: ConferenceMetaData, conferenceEdition: ConferenceEdition, dependency: VideosDependency, componentsRouter: AnyComponentRouter<VideosComponentRoute>) -> Presentable {
        return VideosCoordinator(
            initialRoute: .videos(conferenceMetaData, conferenceEdition),
            depedency: dependency,
            componentsRouter: componentsRouter,
            viewControllerContext: dependencyProvider.viewControllerContext,
            context: dependencyProvider.context)
    }

    public func showVideo(videoMetaData: VideoMetaData, dependency: VideosDependency, componentsRouter: AnyComponentRouter<VideosComponentRoute>) -> Presentable {
        return VideosCoordinator(
            initialRoute: .videoDetail(videoMetaData, true),
            depedency: dependency,
            componentsRouter: componentsRouter,
            viewControllerContext: dependencyProvider.viewControllerContext,
            context: dependencyProvider.context)
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
