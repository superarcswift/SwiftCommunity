//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import RxSwift
import UIKit

class DashboardCoordinator: BaseCoordinator<Void> {

    // MARK: Properties

    // Private

    private let window: UIWindow

    // MARK: Intialization

    init(window: UIWindow, viewControllerContext: ViewControllerContextProtocol) {
        self.window = window
        super.init(viewControllerContext: viewControllerContext)
    }

    // MARK: APIs

    override func start() -> Observable<Void> {
        let dashboardViewController = DashboardViewController.instantiate()
        dashboardViewController.setViewControllerContext(viewControllerContext)
        rootViewController = dashboardViewController.navigationController

        window.rootViewController = dashboardViewController
        window.makeKeyAndVisible()

        setupConferencesCoordinator(with: dashboardViewController)
//        setupVideosCoordinator(with: dashboardViewController)
//        setupAuthorsCoordinator(with: dashboardViewController)

        return Observable.never()
    }

    // MARK: Private helpers

    private func setupConferencesCoordinator(with dashboardViewController: DashboardViewController) {
        let conferencesCoordinator = ConferencesCoordinator(rootViewController: dashboardViewController.conferencesRootViewController)
        coordinate(to: conferencesCoordinator)
            .subscribe()
            .disposed(by: disposeBag)
    }

    private func setupVideosCoordinator(with dashboardViewController: DashboardViewController) {
        let videosCoordinator = VideosCoordinator(rootViewController: dashboardViewController.videosRootViewController)
        coordinate(to: videosCoordinator)
            .subscribe()
            .disposed(by: disposeBag)
    }

    private func setupAuthorsCoordinator(with dashboardViewController: DashboardViewController) {
        let authorsCoordinator = AuthorsCoordinator(rootViewController: dashboardViewController.authorsRootViewController)
        coordinate(to: authorsCoordinator)
            .subscribe()
            .disposed(by: disposeBag)
    }

}
