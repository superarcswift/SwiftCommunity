//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore

// MARK: - FeatureBComponent

public class FeatureBComponent: Component<FeatureBDependency, FeatureBComponentBuilder, FeatureBInterfaceProtocol, FeatureBComponentRoute>, FeatureBComponentBuilder {

    public func makeFeatureBViewController(hasRightCloseButton: Bool = false) -> ComponentPresentable {
        let viewController = FeatureBViewController.instantiate(with: context.viewControllerContext)
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

// MARK: - FeatureBInterfaceProtocol

public protocol FeatureBInterfaceProtocol: Interface {
    func show(dependency: FeatureBDependency, componentsRouter: AnyComponentRouter<FeatureBComponentRoute>, context: ApplicationContextProtocol, hasRightCloseButton: Bool) -> ComponentPresentable
}

// MARK: - FeatureBInterface

public class FeatureBInterface: FeatureBInterfaceProtocol {

    public init() {}

    public func show(dependency: FeatureBDependency, componentsRouter: AnyComponentRouter<FeatureBComponentRoute>, context: ApplicationContextProtocol, hasRightCloseButton: Bool = false) -> ComponentPresentable {
        return FeatureBComponent(dependency: dependency, componentsRouter: componentsRouter, context: context).makeFeatureBViewController(hasRightCloseButton: hasRightCloseButton)
    }
}

// MARK: - FeatureBComponentRouterProtocol

public protocol FeatureBComponentRouterProtocol: ComponentRouter, ComponentRouterIdentifiable where ComponentRouteType == FeatureBComponentRoute {}

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
