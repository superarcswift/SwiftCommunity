//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore

// MARK: - FeatureAComponent

/// Main component class.
public class FeatureAComponent: Component<FeatureADependency, FeatureAComponentBuilder, FeatureAInterfaceProtocol, FeatureAComponentRoute>, FeatureAComponentBuilder {

    public override class func register(to context: ApplicationContextProtocol) {
        let componentsRouter = context.viewControllerContext.resolve(type: Navigator.self)
        componentsRouter.interfaceRegistry.register(FeatureAInterface(context: context), for: FeatureAInterfaceProtocol.self)
    }

    public func makeFeatureAViewController(hasRightCloseButton: Bool = false) -> ComponentPresentable {
        let viewController = FeatureAViewController.instantiate(with: context.viewControllerContext)
        viewController.hasRightCloseButton = hasRightCloseButton
        let navigationController = NavigationController(rootViewController: viewController)
        return navigationController
    }
}

// MARK: - FeatureAComponentBuilder

/// Defining methods used to build all view controllers of this component.
public protocol FeatureAComponentBuilder: ViewBuildable {
    func makeFeatureAViewController(hasRightCloseButton: Bool) -> ComponentPresentable
}

// MARK: - FeatureADependency

/// Protocol defining dependencies that needed to build this component.
public protocol FeatureADependency: Dependency {}

// MARK: - FeatureAInterfaceProtocol

/// Protocol defining methods for outside components to interact with the current components.
public protocol FeatureAInterfaceProtocol: Interface {
    func show(dependency: FeatureADependency, componentsRouter: AnyComponentRouter<FeatureAComponentRoute>, hasRightCloseButton: Bool) -> ComponentPresentable
}

public class FeatureAInterface: FeatureAInterfaceProtocol {

    public var context: ApplicationContextProtocol!

    public init(context: ApplicationContextProtocol) {
        self.context = context
    }

    public func show(dependency: FeatureADependency, componentsRouter: AnyComponentRouter<FeatureAComponentRoute>, hasRightCloseButton: Bool = false) -> ComponentPresentable {
        // TODO: this will create a new FeatureAComponent everytime. See if we can keep it in the memory and release it when needed.
        let component = FeatureAComponent(dependency: dependency, componentsRouter: componentsRouter, context: context)
        return component.makeFeatureAViewController(hasRightCloseButton: hasRightCloseButton)
    }
}

// MARK: - FeatureAComponentRouterProtocol

/// Protocol defining a router used to navigate to outside components from this component.
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

/// List of outside routes that this component can navigate to.
public enum FeatureAComponentRoute: ComponentRoute {
    case featureB
    case featureC
    case featureD
}
