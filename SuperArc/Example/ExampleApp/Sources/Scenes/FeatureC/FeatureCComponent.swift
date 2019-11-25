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
    func show(dependency: FeatureCDependency, hasRightCloseButton: Bool) -> ComponentPresentable
}

class FeatureCComponent: Component<FeatureCDependency, FeatureCComponentBuilder, FeatureCInterfaceProtocol, EmptyComponentRoute> {

    public override class func register(to context: ApplicationContextProtocol) {
        let componentsRouter = context.viewControllerContext.resolve(type: Navigator.self)
        componentsRouter.interfaceRegistry.register(FeatureCInterface(context: context), for: FeatureCInterfaceProtocol.self)
    }

    func makeFeatureCViewController(hasRightCloseButton: Bool = false) -> ComponentPresentable {
        let viewController = FeatureCViewController.instantiate(with: context.viewControllerContext)
        viewController.hasRightCloseButton = hasRightCloseButton
        let navigationController = NavigationController(rootViewController: viewController)
        return navigationController
    }
}

// MARK: - AuthorsInterface

class FeatureCInterface: FeatureCInterfaceProtocol {

    var context: ApplicationContextProtocol!

    init(context: ApplicationContextProtocol) {
        self.context = context
    }

    func show(dependency: FeatureCDependency, hasRightCloseButton: Bool = false) -> ComponentPresentable {
        let component = FeatureCComponent(dependency: dependency, context: context)
        return component.makeFeatureCViewController(hasRightCloseButton: hasRightCloseButton)
    }
}
