//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SwiftVideos_Core
import SwiftVideos_DataModels
import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import XCoordinator

/// Protocol defining all dependencies required by this component.
typealias VideosDependency = HasVideosService & HasAuthorsService

/// Protocol can be used used to mock for testing purpose.
protocol VideosBuilder {

    func makeVideosCollectionViewController(conferenceMetaData: ConferenceMetaData?, conferenceEdition: ConferenceEdition?, router: AnyRouter<VideosRoute>) -> VideosCollectionViewController

    func makeVideoDetailViewController(videoMetaData: VideoMetaData, hasLeftCloseButton: Bool, router: AnyRouter<VideosRoute>) -> VideoDetailViewController
}

class VideosComponent: Component<VideosDependency>, VideosBuilder {

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
