//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import RxSwift
import UIKit

class AppCoordinator: BaseCoordinator<Void> {

    // MARK: Properties

    private let window: UIWindow

    // MARK: Initialization

    init(window: UIWindow, viewControllerContext: ViewControllerContextProtocol) {
        self.window = window

        super.init(viewControllerContext: viewControllerContext)
    }

    // MARK: Overriden

    @discardableResult
    override func start() -> Observable<Void> {
        let dashboardCoordinator = DashboardCoordinator(window: window, viewControllerContext: viewControllerContext)
        return coordinate(to: dashboardCoordinator)
    }
}
