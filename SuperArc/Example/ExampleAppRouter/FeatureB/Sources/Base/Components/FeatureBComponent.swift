//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore

// MARK: - FeatureBComponent

public class FeatureBComponent: Component<FeatureBDependency, FeatureBComponentBuilder, FeatureBInterfaceProtocol, FeatureBComponentRoute>, FeatureBComponentBuilder {

    public override class func register(to context: ApplicationContextProtocol, navigator: NavigatorProtocol, dependencyProvider: DependencyProvider) {
        navigator.interfaceRegistry.register(FeatureBInterface(viewControllerContext: context.viewControllerContext, dependencyProvider: dependencyProvider), for: FeatureBInterfaceProtocol.self)
    }


    public func makeFeatureBViewController(hasRightCloseButton: Bool = false) -> ComponentPresentable {
        let viewController = FeatureBViewController.instantiate(with: viewControllerContext)
        viewController.hasRightCloseButton = hasRightCloseButton
        let navigationController = NavigationController(rootViewController: viewController)
        return navigationController
    }

}

// MARK: - FeatureBComponentBuilder

public protocol FeatureBComponentBuilder: ViewBuildable {
    func makeFeatureBViewController(hasRightCloseButton: Bool) -> ComponentPresentable
}

// MARK: - FeatureBDependency

public protocol FeatureBDependency: Dependency {}

// MARK: - FeatureBInterface

public protocol FeatureBInterfaceProtocol: Interface {
    func show(dependency: FeatureBDependency, router: AnyComponentRouter<FeatureBComponentRoute>, hasRightCloseButton: Bool) -> ComponentPresentable
}

public class FeatureBInterface: FeatureBInterfaceProtocol {

    public var viewControllerContext: ViewControllerContext!
    public var dependencyProvider: DependencyProvider

    public init(viewControllerContext: ViewControllerContext, dependencyProvider: DependencyProvider) {
        self.viewControllerContext = viewControllerContext
        self.dependencyProvider = dependencyProvider
    }

    public func show(dependency: FeatureBDependency, router: AnyComponentRouter<FeatureBComponentRoute>, hasRightCloseButton: Bool = false) -> ComponentPresentable {
        let component = FeatureBComponent(dependency: dependency,
                                          router: router,
                                          viewControllerContext: viewControllerContext,
                                          dependencyProvider: dependencyProvider)
        return component.viewBuilder.makeFeatureBViewController(hasRightCloseButton: hasRightCloseButton)
    }
}

// MARK: - FeatureBComponentRouterProtocol

public protocol FeatureBComponentRouterProtocol: ComponentRouter where ComponentRouteType == FeatureBComponentRoute {}

public extension FeatureBComponentRouterProtocol where ComponentRouteType == FeatureBComponentRoute {

    var anyFeatureBRouter: AnyComponentRouter<FeatureBComponentRoute> {
        return AnyComponentRouter(self)
    }
}

public protocol HasFeatureBComponentRouter {
    var featureBRouter: AnyComponentRouter<FeatureBComponentRoute> { get }
}

public enum FeatureBComponentRoute: ComponentRoute {
    case featureA
    case featureC
    case featureD
}
