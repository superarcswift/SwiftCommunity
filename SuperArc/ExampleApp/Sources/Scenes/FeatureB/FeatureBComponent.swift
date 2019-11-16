//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore

// MARK: - FeatureBComponent

public class FeatureBComponent: Component<FeatureBDependency, FeatureBComponentBuilder, FeatureBInterfaceProtocol, EmptyComponentRoute>, FeatureBComponentBuilder {

    public override class func register(to context: ApplicationContextProtocol) {
        let componentsRouter = context.viewControllerContext.resolve(type: ComponentsRouter.self)
        componentsRouter.interfaceRegistry.register(FeatureBInterface(context: context), for: FeatureBInterfaceProtocol.self)
    }

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

// MARK: - FeatureBInterface

public protocol FeatureBInterfaceProtocol: Interface {
    func show(dependency: FeatureBDependency, hasRightCloseButton: Bool) -> ComponentPresentable
}

public class FeatureBInterface: FeatureBInterfaceProtocol {

    public var context: ApplicationContextProtocol!

    public init(context: ApplicationContextProtocol) {
        self.context = context
    }

    public func show(dependency: FeatureBDependency, hasRightCloseButton: Bool = false) -> ComponentPresentable {
        let component = FeatureBComponent(dependency: dependency, context: context)
        return component.viewBuilder.makeFeatureBViewController(hasRightCloseButton: hasRightCloseButton)
    }
}
