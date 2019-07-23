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

    private var viewControllerContext: ViewControllerContext

    // MARK: Initialization

    init(viewControllerContext: ViewControllerContext) {
        self.viewControllerContext = viewControllerContext
        super.init(initialRoute: .videos)
    }

    // MARK: Overrides

    override func prepareTransition(for route: VideosRoute) -> NavigationTransition {
        switch route {
        case .videos:
            let viewController = VideosCollectionViewController.instantiate()
            let viewModel = VideosCollectionViewModel(router: anyRouter, engine: viewControllerContext.engine)
            viewController.storedViewModel = viewModel
            return .push(viewController)

        case .videoDetail(let video):
            let viewController = VideoDetailViewController.instantiate()
            let viewModel = VideoDetailViewModel(video: video, router: anyRouter, engine: viewControllerContext.engine)
            viewController.storedViewModel = viewModel
            return .push(viewController)

        case .close:
            return .dismissToRoot()
        }
    }

}

enum VideosRoute: Route {
    case videos
    case videoDetail(Video)
    case close
}
