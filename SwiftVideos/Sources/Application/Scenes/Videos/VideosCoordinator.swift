//
//  Copyright © 2019 An Tran. All rights reserved.
//

import XCoordinator
import SuperArcCoreUI
import SuperArcCore
import RxSwift

class VideosCoordinator: NavigationCoordinator<VideosRoute> {

    // MARK: Properties

    // Private

    private var context: ApplicationContext

    // MARK: Initialization

    init(initialRoute: VideosRoute, context: ApplicationContext) {
        self.context = context
        super.init(initialRoute: initialRoute)
    }

    // MARK: Overrides

    override func prepareTransition(for route: VideosRoute) -> NavigationTransition {
        switch route {
        case .videos(let conferenceMetaData, let conferenceEdition):
            // TODO: move creating VC to private func
            let viewController = VideosCollectionViewController.instantiate(with: context)
            viewController.setApplicationContext(context)
            if conferenceMetaData != nil {
                viewController.hasLeftCloseButton = true
            }
            let viewModel = VideosCollectionViewModel(router: anyRouter, engine: context.engine, conferenceMetaData: conferenceMetaData, conferenceEdition: conferenceEdition)
            viewController.storedViewModel = viewModel
            return .push(viewController)

        case .videoDetail(let videoMetaData, let hasLeftCloseButton):
            // TODO: move creating VC to private func
            let viewController = VideoDetailViewController.instantiate(with: context)
            viewController.setApplicationContext(context)
            let viewModel = VideoDetailViewModel(videoMetaData: videoMetaData, router: anyRouter, engine: context.engine)
            viewController.storedViewModel = viewModel
            viewController.hasLeftCloseButton = hasLeftCloseButton
            return .push(viewController)

        case .videoPlayer(let videoMetaData):
            // TODO: move creating VC to private func
            let viewController = VideoPlayerViewController.instantiate(with: context)
            viewController.setApplicationContext(context)
            let viewModel = VideoPlayerViewModel(videoMetaData: videoMetaData, engine: context.engine)
            viewController.storedViewModel = viewModel
            return .push(viewController)

        case .close:
            return .dismissToRoot()
        }
    }

}

public enum VideosRoute: Route {
    case videos(ConferenceMetaData?, ConferenceEdition?)
    case videoDetail(VideoMetaData, Bool)
    case videoPlayer(VideoMetaData)
    case close
}
