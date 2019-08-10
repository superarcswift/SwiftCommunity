//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import XCoordinator

/// Protocol defining all dependencies required by this component..
typealias VideosDependency = Dependency & HasVideosService

/// Protocol used to mock for testing purpose.
protocol VideosBuilder {
    func makeVideosCollectionViewController(conferenceMetaData: ConferenceMetaData?, conferenceEdition: ConferenceEdition?, router: AnyRouter<VideosRoute>) -> VideosCollectionViewController
    func makeVideoDetailViewController(videoMetaData: VideoMetaData, hasLeftCloseButton: Bool, router: AnyRouter<VideosRoute>) -> VideoDetailViewController
    func makeVideoPlayerViewController(videoMetaData: VideoMetaData) -> VideoPlayerViewController
}

class VideosComponent: Component<VideosDependency>, VideosBuilder {

    // MARK: APIs

    func makeVideosCollectionViewController(conferenceMetaData: ConferenceMetaData?, conferenceEdition: ConferenceEdition?, router: AnyRouter<VideosRoute>) -> VideosCollectionViewController {

        let viewController = VideosCollectionViewController.instantiate(with: context)
        viewController.setApplicationContext(context)
        if conferenceMetaData != nil {
            viewController.hasLeftCloseButton = true
        }
        let viewModel = VideosCollectionViewModel(router: router, dependency: dependency, engine: context.engine, conferenceMetaData: conferenceMetaData, conferenceEdition: conferenceEdition)
        viewController.storedViewModel = viewModel

        return viewController
    }

    func makeVideoDetailViewController(videoMetaData: VideoMetaData, hasLeftCloseButton: Bool, router: AnyRouter<VideosRoute>) -> VideoDetailViewController {
        let viewController = VideoDetailViewController.instantiate(with: context)
        viewController.setApplicationContext(context)
        let viewModel = VideoDetailViewModel(videoMetaData: videoMetaData, router: router, dependency: dependency, engine: context.engine)
        viewController.storedViewModel = viewModel
        viewController.hasLeftCloseButton = hasLeftCloseButton

        return viewController
    }

    func makeVideoPlayerViewController(videoMetaData: VideoMetaData) -> VideoPlayerViewController {
        let viewController = VideoPlayerViewController.instantiate(with: context)
        viewController.setApplicationContext(context)
        let viewModel = VideoPlayerViewModel(videoMetaData: videoMetaData, engine: context.engine)
        viewController.storedViewModel = viewModel

        return viewController
    }
}
