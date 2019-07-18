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
        return Observable.just(())
    }
}
