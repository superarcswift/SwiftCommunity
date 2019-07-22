//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoordinator
import SuperArcCoreUI
import SuperArcCore
import RxSwift

class VideosCoordinator: BaseCoordinator<Void> {

    // MARK: Properties

    // MARK: Initialization

    init(rootViewController: NavigationController) {
        super.init(viewControllerContext: rootViewController.context)
        self.rootViewController = rootViewController
    }

    // MARK: APIs

    override func start() -> Observable<Void> {
        videosCollectionViewController.loadViewIfNeeded()
        let viewModel = videosCollectionViewController.viewModel
        viewModel.didSelect.subscribe { [weak self] videoEvent in
            guard let video = videoEvent.element else {
                return
            }
            self?.navigateToDetail(for: video)
        }.disposed(by: disposeBag)

        return Observable.never()
    }

    // MARK: Private helpers

    private func navigateToDetail(for video: Video) {
        let videoDetailViewController = VideoDetailViewController.instantiate()
        videoDetailViewController.setViewControllerContext(viewControllerContext)
        rootViewController?.pushViewController(videoDetailViewController, animated: true)
    }

    private var videosCollectionViewController: VideosCollectionViewController {
        return rootViewController?.topViewController as! VideosCollectionViewController
    }
}
