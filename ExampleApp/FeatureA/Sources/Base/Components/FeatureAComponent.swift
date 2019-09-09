//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import XCoordinator


// MARK: - FeatureAComponent

public class FeatureAComponent: Component<FeatureADependency, FeatureAComponentBuilder, FeatureAInterfaceProtocol, FeatureAComponentRoute>, FeatureAComponentBuilder {

    public func makeFeatureAViewController(hasRightCloseButton: Bool = false) -> ComponentPresentable {
        let viewController = FeatureAViewController.instantiate(with: context.viewControllerContext)
        viewController.hasRightCloseButton = hasRightCloseButton
        let navigationController = NavigationController(rootViewController: viewController)
        return navigationController
    }
}

// MARK: - FeatureAComponentBuilder

public protocol FeatureAComponentBuilder: ViewBuildable {
    func makeFeatureAViewController(hasRightCloseButton: Bool) -> ComponentPresentable
}

// MARK: -FeatureADependency

public protocol FeatureADependency: Dependency {}

// MARK: - FeatureAInterfaceProtocol

public protocol FeatureAInterfaceProtocol: Interface {
    func show(dependency: FeatureADependency, componentsRouter: AnyComponentRouter<FeatureAComponentRoute>, context: ApplicationContextProtocol, hasRightCloseButton: Bool) -> ComponentPresentable
}


// MARK: - AuthorsInterface

public class FeatureAInterface: FeatureAInterfaceProtocol {

    public init() {}

    public func show(dependency: FeatureADependency, componentsRouter: AnyComponentRouter<FeatureAComponentRoute>, context: ApplicationContextProtocol, hasRightCloseButton: Bool = false) -> ComponentPresentable {
        return FeatureAComponent(dependency: dependency, componentsRouter: componentsRouter, context: context).makeFeatureAViewController(hasRightCloseButton: hasRightCloseButton)
    }
}

// MARK: - FeatureAComponentRouterProtocol

public protocol FeatureAComponentRouterProtocol: ComponentRouter, ComponentRouterIdentifiable where ComponentRouteType == FeatureAComponentRoute {}

extension FeatureAComponentRouterProtocol where ComponentRouteType == FeatureAComponentRoute {

    public var anyFeatureARouter: AnyComponentRouter<FeatureAComponentRoute> {
        return AnyComponentRouter(self)
    }
}

public protocol HasFeatureAComponentRouter {
    var featureARouter: AnyComponentRouter<FeatureAComponentRoute> { get }
}

// MARK: - FeatureAComponentRoute

public enum FeatureAComponentRoute: ComponentRoute {
    case featureB
    case featureC
    case featureD
}
