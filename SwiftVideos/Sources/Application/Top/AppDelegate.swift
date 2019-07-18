//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Properties

    // Public

    let appManager: AppManager

    var window: UIWindow?

    // Private

    private var appCoordinator: AppCoordinator!

    // MARK: Initialization

    override init() {
        appManager = AppManager()

        super.init()
    }

    // MARK: Lifefycles

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = AppCoordinator(window: window!, viewControllerContext: appManager.core.viewControllerContext)
        appCoordinator.start()

        return true
    }

}
