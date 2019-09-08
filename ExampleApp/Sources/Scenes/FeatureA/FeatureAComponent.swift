//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import XCoordinator

protocol FeatureAComponentBuilder: ViewBuildable {
    func makeFeatureAViewController(hasRightCloseButton: Bool) -> ComponentPresentable
}

protocol FeatureADependency: Dependency {}

protocol FeatureAInterfaceProtocol: Interface {
    func show(dependency: FeatureADependency, componentsRouter: AnyComponentRouter<FeatureAComponentRoute>, context: ApplicationContextProtocol, hasRightCloseButton: Bool) -> ComponentPresentable
}

protocol FeatureAComponentRouterProtocol: ComponentRouter, ComponentRouterIdentifiable where ComponentRouteType == FeatureAComponentRoute {}

extension FeatureAComponentRouterProtocol where ComponentRouteType == FeatureAComponentRoute {

    var anyFeatureARouter: AnyComponentRouter<FeatureAComponentRoute> {
        return AnyComponentRouter(self)
    }
}

class FeatureAComponent: Component<FeatureADependency, FeatureAComponentBuilder, FeatureAInterfaceProtocol, FeatureAComponentRoute>, FeatureAComponentBuilder {

    func makeFeatureAViewController(hasRightCloseButton: Bool = false) -> ComponentPresentable {
        let viewController = FeatureAViewController.instantiate(with: context.viewControllerContext)
        viewController.hasRightCloseButton = hasRightCloseButton
        let navigationController = NavigationController(rootViewController: viewController)
        return navigationController
    }
}

// MARK: - AuthorsInterface

class FeatureAInterface: FeatureAInterfaceProtocol {

    public init() {}

    func show(dependency: FeatureADependency, componentsRouter: AnyComponentRouter<FeatureAComponentRoute>, context: ApplicationContextProtocol, hasRightCloseButton: Bool = false) -> ComponentPresentable {
        return FeatureAComponent(dependency: dependency, componentsRouter: componentsRouter, context: context).makeFeatureAViewController(hasRightCloseButton: hasRightCloseButton)
    }
}

// MARK: - AuthorsInterface

enum FeatureAComponentRoute: ComponentRoute {
    case featureB
    case featureC
    case featureD
}
