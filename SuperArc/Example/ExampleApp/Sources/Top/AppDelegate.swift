//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCore
import SuperArcFoundation
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var core: Core!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Initialize Core
        #if DEBUG
        let endpoint: Endpoint = .development
        #else
        let endpoint: Endpoint = .production
        #endif
        let configurations = AnyRegistry(ConfigurationsRegistry(endpoint: endpoint))
        core = Core(endpoint: endpoint, configurations: configurations)

        // Initialize ComponentsRouter
        let componentsRouter = Navigator(context: core.context)
        core.context.viewControllerContext.register(componentsRouter, for: Navigator.self)

        // Register Components
        FeatureAComponent.register(to: core.context)
        FeatureBComponent.register(to: core.context)
        FeatureCComponent.register(to: core.context)
        FeatureDComponent.register(to: core.context)

        // Initialize first screen
        let dashboardComponent = DashboardComponent(dependency: EmptyComponent(), context: core.context)

        // Show the app
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = dashboardComponent.makeDashboardViewController()
        window?.makeKeyAndVisible()

        return true
    }
}

