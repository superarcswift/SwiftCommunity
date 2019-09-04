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

class VideosComponent: Component<VideosDependency, VideosViewBuilder, VideosNavigationDelegate, VideosInterfaceProtocol>, VideosViewBuilder {

    // MARK: Initialization

    override init(dependency: DependencyType, context: ApplicationContextProtocol) {
        super.init(dependency: dependency, context: context)
        navigationDelegate = context.viewControllerContext.resolve(type: ComponentsInteractorProtocol.self) as? VideosNavigationDelegate
    }

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
}

public struct VideosInterface: VideosInterfaceProtocol {

    public init() {}

    public func showVideo(conferenceMetaData: ConferenceMetaData, conferenceEdition: ConferenceEdition, dependency: VideosDependency, context: ApplicationContextProtocol) -> Presentable {
        return VideosCoordinator(initialRoute: .videos(conferenceMetaData, conferenceEdition), depedency: dependency, context: context)
    }

    public func showVideo(videoMetaData: VideoMetaData, dependency: VideosDependency, context: ApplicationContextProtocol) -> Presentable {
        return VideosCoordinator(initialRoute: .videoDetail(videoMetaData, true), depedency: dependency, context: context)
    }

}

// MARK: Children's dependencies

extension VideosComponent: HasAuthorsService {

    var authorsService: AuthorsServiceProtocol {
        return context.engine.serviceRegistry.resolve(type: AuthorsServiceProtocol.self)
    }
}

extension VideosComponent: HasVideosService {

    var videosService: VideosServiceProtocol {
        return context.engine.serviceRegistry.resolve(type: VideosServiceProtocol.self)
    }
}
