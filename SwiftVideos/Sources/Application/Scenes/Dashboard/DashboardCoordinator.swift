//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import RxSwift
import UIKit

class DashboardCoordinator: BaseCoordinator<Void> {

    // MARK: Properties

    private let window: UIWindow

    private let disposeBag = DisposeBag()

    // MARK: Intialization

    init(window: UIWindow, viewControllerContext: ViewControllerContextProtocol) {
        self.window = window
        super.init(viewControllerContext: viewControllerContext)
    }

    // MARK: Overriden

    override func start() -> Observable<Void> {
        let dashboardViewController = DashboardViewController.instantiate()
        dashboardViewController.setViewControllerContext(viewControllerContext)
        window.rootViewController = dashboardViewController
        window.makeKeyAndVisible()

        let conferencesCoordinator = ConferencesCoordinator(navigationController: dashboardViewController.children[0] as! NavigationController)
        let videosCoordinator = VideosCoordinator(viewControllerContext: viewControllerContext)
        let authorsCoordinator = AuthorsCoordinator(viewControllerContext: viewControllerContext)

        coordinate(to: conferencesCoordinator)
            .subscribe()
            .disposed(by: disposeBag)

        coordinate(to: videosCoordinator)
            .subscribe()
            .disposed(by: disposeBag)

        coordinate(to: authorsCoordinator)
            .subscribe()
            .disposed(by: disposeBag)

        return Observable.never()
    }
}
