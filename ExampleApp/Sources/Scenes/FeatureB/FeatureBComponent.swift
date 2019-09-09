//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore

// MARK: - FeatureBComponent

class FeatureBComponent: Component<FeatureBDependency, FeatureBComponentBuilder, FeatureBInterfaceProtocol, FeatureBComponentRoute>, FeatureBComponentBuilder {

    func makeFeatureBViewController(hasRightCloseButton: Bool = false) -> ComponentPresentable {
        let viewController = FeatureBViewController.instantiate(with: context.viewControllerContext)
        viewController.hasRightCloseButton = hasRightCloseButton
        let navigationController = NavigationController(rootViewController: viewController)
        return navigationController
    }

}

// MARK: - FeatureBComponentBuilder

protocol FeatureBComponentBuilder: ViewBuildable {
    func makeFeatureBViewController(hasRightCloseButton: Bool) -> ComponentPresentable
}

// MARK: - FeatureBDependency

protocol FeatureBDependency: Dependency {}

// MARK: - FeatureBInterfaceProtocol

protocol FeatureBInterfaceProtocol: Interface {
    func show(dependency: FeatureBDependency, componentsRouter: AnyComponentRouter<FeatureBComponentRoute>, context: ApplicationContextProtocol, hasRightCloseButton: Bool) -> ComponentPresentable
}

// MARK: - FeatureBInterface

class FeatureBInterface: FeatureBInterfaceProtocol {

    public init() {}

    func show(dependency: FeatureBDependency, componentsRouter: AnyComponentRouter<FeatureBComponentRoute>, context: ApplicationContextProtocol, hasRightCloseButton: Bool = false) -> ComponentPresentable {
        return FeatureBComponent(dependency: dependency, componentsRouter: componentsRouter, context: context).makeFeatureBViewController(hasRightCloseButton: hasRightCloseButton)
    }
}

// MARK: - FeatureBComponentRouterProtocol

protocol FeatureBComponentRouterProtocol: ComponentRouter, ComponentRouterIdentifiable where ComponentRouteType == FeatureBComponentRoute {}

extension FeatureBComponentRouterProtocol where ComponentRouteType == FeatureBComponentRoute {

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
