//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoordinator
import SuperArcCoreUI
import SuperArcCore
import RxSwift

class AuthorsCoordinator: BaseCoordinator<Void> {

    // MARK: Properties

    // MARK: Initialization

    init(rootViewController: NavigationController) {
        super.init(viewControllerContext: rootViewController.context)
        self.rootViewController = rootViewController
    }

    // MARK: APIs

    override func start() -> Observable<Void> {
        authorsCollectionViewController.loadViewIfNeeded()
        let viewModel = authorsCollectionViewController.viewModel
        viewModel.didSelect.subscribe { [weak self] event in
            guard let author = event.element else {
                return
            }
            self?.navigateToDetail(for: author)
            }.disposed(by: disposeBag)

        return Observable.never()
    }

    // MARK: Private helpers

    private func navigateToDetail(for author: Author) {
        let videoDetailViewController = AuthorDetailViewController.instantiate()
        videoDetailViewController.setViewControllerContext(viewControllerContext)
        rootViewController?.pushViewController(videoDetailViewController, animated: true)
    }

    private var authorsCollectionViewController: AuthorsCollectionViewController {
        return rootViewController?.topViewController as! AuthorsCollectionViewController
    }
}
