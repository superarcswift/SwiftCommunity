//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import XCoordinator
import RxSwift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Properties

    // Public

    let appManager: AppManager

    var window: UIWindow? = UIWindow()

    // Private

    private lazy var appComponent = AppComponent(dependency: EmptyComponent(), context: appManager.core.context)

    // MARK: Initialization

    override init() {
        appManager = AppManager()
        super.init()
    }

    // MARK: Lifefycles

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        appComponent.setRoot(for: window!)

        return true
    }

}
