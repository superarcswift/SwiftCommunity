//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore

protocol FeatureCComponentBuilder: ViewBuildable {
    func makeFeatureCViewController(hasRightCloseButton: Bool) -> ComponentPresentable
}

protocol FeatureCDependency: Dependency {
}

protocol FeatureCInterfaceProtocol: Interface {
    func show(dependency: FeatureCDependency, context: ApplicationContextProtocol, hasRightCloseButton: Bool) -> ComponentPresentable
}

class FeatureCComponent: Component<FeatureCDependency, FeatureCComponentBuilder, FeatureCInterfaceProtocol, EmptyComponentRoute> {

    func makeFeatureCViewController(hasRightCloseButton: Bool = false) -> ComponentPresentable {
        let viewController = FeatureCViewController.instantiate(with: context.viewControllerContext)
        viewController.hasRightCloseButton = hasRightCloseButton
        let navigationController = NavigationController(rootViewController: viewController)
        return navigationController
    }
}

// MARK: - AuthorsInterface

class FeatureCInterface: FeatureCInterfaceProtocol {

    init() {}

    func show(dependency: FeatureCDependency, context: ApplicationContextProtocol, hasRightCloseButton: Bool = false) -> ComponentPresentable {
        return FeatureCComponent(dependency: dependency, componentsRouter: AnyEmptyComponentRouter(), context: context).makeFeatureCViewController(hasRightCloseButton: hasRightCloseButton)
    }
}
