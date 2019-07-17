//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Properties

    let appManager: AppManager

    var window: UIWindow?

    // MARK: Initialization

    override init() {
        appManager = AppManager()

        super.init()
    }

    // MARK: Lifefycles

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        let dashboardViewController = DashboardViewController.instantiate()
        dashboardViewController.setViewControllerContext(appManager.core.viewControllerContext)
        window?.rootViewController = dashboardViewController
        window?.makeKeyAndVisible()

        return true
    }

}
