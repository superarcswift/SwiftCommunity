//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import DataModels
import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import UIKit

// MARK: - AuthorsComponent

class AlgorithmComponent: Component<EmptyDependency, AlgorithmViewBuilder, EmptyInterface, EmptyComponentRoute>, AlgorithmViewBuilder {

    // MARK: APIs

    func makeDashboardViewController(viewControllerContext: ViewControllerContext) -> UIViewController {

        let viewController = DashboardViewController.instantiate(with: viewControllerContext)
        return viewController
    }
}

// MARK: - AuthorsViewBuilder

protocol AlgorithmViewBuilder: ViewBuildable {
    func makeDashboardViewController(viewControllerContext: ViewControllerContext) -> UIViewController
}

// MARK: AuthorsInterfaceProtocol

public class AlgorithmInterface: AlgorithmInterfaceProtocol, OnDemandInterface {


    // MARK: Properties

    private weak var componentsRouter: ComponentsRouter!
    private weak var dependencyProvider: DependencyProvider!
    private weak var viewControllerContext: ViewControllerContext!

    // MARK: Initialization

    public required init(onDemandWith componentsRouter: ComponentsRouter, viewControllerContext: ViewControllerContext, and dependencyProvider: DependencyProvider) {
        self.componentsRouter = componentsRouter
        self.viewControllerContext = viewControllerContext
        self.dependencyProvider = dependencyProvider
    }

    // MARK: APIs

    public func showDashboard() -> UIViewController {
        return UIViewController()
    }
}

// MARK: - AuthorsComponentRouter

public protocol AuthorsComponentRouterProtocol: ComponentRouter, ComponentRouterIdentifiable where ComponentRouteType == AuthorsComponentRoute {}

extension AuthorsComponentRouterProtocol where ComponentRouteType == AuthorsComponentRoute {

    public var anyAuthorsRouter: AnyComponentRouter<AuthorsComponentRoute> {
        return AnyComponentRouter(self)
    }
}

public enum AuthorsComponentRoute: ComponentRoute {
    case video(VideoMetaData)
}
