//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoordinator
import SuperArcCoreUI
import SuperArcCore
import RxSwift

class ConferencesCoordinator: BaseCoordinator<Void> {

    // MARK: Properties

    // Private

    // MARK: Initialization

    init(rootViewController: NavigationController) {
        super.init(viewControllerContext: rootViewController.context)
        self.rootViewController = rootViewController
    }

    // MARK: APIs

    override func start() -> Observable<Void> {
        conferencesCollectionViewController.loadViewIfNeeded()
        let viewModel = conferencesCollectionViewController.viewModel
        viewModel.didSelect.subscribe { [weak self] conferenceEvent in
            guard let conference = conferenceEvent.element else {
                return
            }
            self?.navigateToDetail(for: conference)
        }.disposed(by: disposeBag)

        return Observable.never()
    }

    // MARK: Private helpers

    private func navigateToDetail(for conference: Conference) {
        let conferenceDetailViewController = ConferencesDetailViewController.instantiate()
        conferenceDetailViewController.setViewControllerContext(viewControllerContext)
        rootViewController?.pushViewController(conferenceDetailViewController, animated: true)
    }

    private var conferencesCollectionViewController: ConferencesCollectionViewController {
        return rootViewController?.topViewController as! ConferencesCollectionViewController
    }
}
