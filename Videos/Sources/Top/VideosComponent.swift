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

/// Protocol can be used used to mock for testing purpose.
protocol VideosViewBuilder: ViewBuildable {
    func makeVideosCollectionViewController(conferenceMetaData: ConferenceMetaData?, conferenceEdition: ConferenceEdition?, router: AnyRouter<VideosRoute>) -> VideosCollectionViewController
    func makeVideoDetailViewController(videoMetaData: VideoMetaData, hasLeftCloseButton: Bool, router: AnyRouter<VideosRoute>) -> VideoDetailViewController
}

public protocol VideosComponentRouterProtocol: ComponentRouter, ComponentRouterIdentifiable where ComponentRouteType == VideosComponentRoute {}

extension VideosComponentRouterProtocol where ComponentRouteType == VideosComponentRoute {

    public var anyVideosRouter: AnyComponentRouter<VideosComponentRoute> {
        return AnyComponentRouter(self)
    }
}

class VideosComponent: Component<VideosDependency, VideosViewBuilder, VideosInterfaceProtocol, VideosComponentRoute>, VideosViewBuilder {

    // MARK: APIs

    func makeVideosCollectionViewController(conferenceMetaData: ConferenceMetaData?, conferenceEdition: ConferenceEdition?, router: AnyRouter<VideosRoute>) -> VideosCollectionViewController {

        let viewController = VideosCollectionViewController.instantiate(with: context.viewControllerContext)
        if conferenceMetaData != nil {
            viewController.hasLeftCloseButton = true
        }
        let viewModel = VideosCollectionViewModel(router: router, dependency: dependency, conferenceMetaData: conferenceMetaData, conferenceEdition: conferenceEdition)
        viewController.viewModel = viewModel

        return viewController
    }

    func makeVideoDetailViewController(videoMetaData: VideoMetaData, hasLeftCloseButton: Bool, router: AnyRouter<VideosRoute>) -> VideoDetailViewController {
        let viewController = VideoDetailViewController.instantiate(with: context.viewControllerContext)
        viewController.videosComponent = self
        let viewModel = VideoDetailViewModel(router: router, dependency: dependency, videoMetaData: videoMetaData)
        viewController.viewModel = viewModel
        viewController.hasLeftCloseButton = hasLeftCloseButton

        return viewController
    }

    override func trigger(_ route: VideosComponentRoute) -> Presentable {
        return componentsRouter.trigger(route)
    }
}

public class VideosInterface: VideosInterfaceProtocol {

    // MARK: Initialization

    public init() {}

    // MARK: APIs

    public func showVideo(conferenceMetaData: ConferenceMetaData, conferenceEdition: ConferenceEdition, dependency: VideosDependency, componentsRouter: AnyComponentRouter<VideosComponentRoute>, context: ApplicationContextProtocol) -> Presentable {
        return VideosCoordinator(initialRoute: .videos(conferenceMetaData, conferenceEdition), depedency: dependency, componentsRouter: componentsRouter, context: context)
    }

    public func showVideo(videoMetaData: VideoMetaData, dependency: VideosDependency, componentsRouter: AnyComponentRouter<VideosComponentRoute>, context: ApplicationContextProtocol) -> Presentable {
        return VideosCoordinator(initialRoute: .videoDetail(videoMetaData, true), depedency: dependency, componentsRouter: componentsRouter, context: context)
    }

}

public enum VideosComponentRoute: ComponentRoute {
    case author(AuthorMetaData)
}
