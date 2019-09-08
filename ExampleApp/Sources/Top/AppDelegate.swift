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
    var componentsRouter: ComponentsRouterProtocol!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        #if DEBUG
        let endpoint: Endpoint = .development
        #else
        let endpoint: Endpoint = .production
        #endif
        let configurations = AnyRegistry(ConfigurationsRegistry(endpoint: endpoint))
        core = Core(endpoint: endpoint, configurations: configurations)

        let componentsRouter = ComponentsRouter(context: core.context)
        // TODO: register this by default in core. componentsRouter should be injected with default value = SuperArcCore.ComponentsRouter
        core.context.viewControllerContext.register(componentsRouter, for: ComponentsRouterProtocol.self)
        componentsRouter.interfaceRegistry.register(FeatureAInterface(), for: FeatureAInterfaceProtocol.self)
        componentsRouter.interfaceRegistry.register(FeatureBInterface(), for: FeatureBInterfaceProtocol.self)
        componentsRouter.interfaceRegistry.register(FeatureCInterface(), for: FeatureCInterfaceProtocol.self)
        componentsRouter.interfaceRegistry.register(FeatureDInterface(), for: FeatureDInterfaceProtocol.self)

        componentsRouter.routerRegistry.register(FeatureAComponentRouter(context: core.context), for: FeatureAComponentRouter.self)
        componentsRouter.routerRegistry.register(FeatureBComponentRouter(context: core.context), for: FeatureBComponentRouter.self)


        let dashboardComponent = DashboardComponent(dependency: EmptyComponent(), context: core.context)
        window?.rootViewController = dashboardComponent.makeDashboardViewController()
        window?.makeKeyAndVisible()

        return true
    }
}

