//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore

// MARK: - FeatureBComponent

public class FeatureBComponent: Component<FeatureBDependency, FeatureBComponentBuilder, FeatureBInterfaceProtocol, EmptyComponentRoute>, FeatureBComponentBuilder {

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
    func show(dependency: FeatureBDependency, hasRightCloseButton: Bool) -> ComponentPresentable
}

public class FeatureBInterface: FeatureBInterfaceProtocol {

    // MARK: Properties

    public var viewControllerContext: ViewControllerContext!
    public var dependencyProvider: DependencyProvider

    // MARK: Initialization

    public init(viewControllerContext: ViewControllerContext, dependencyProvider: DependencyProvider) {
        self.viewControllerContext = viewControllerContext
        self.dependencyProvider = dependencyProvider
    }

    // MARK: APIs

    public func show(dependency: FeatureBDependency, hasRightCloseButton: Bool = false) -> ComponentPresentable {
        let component = FeatureBComponent(dependency: dependency,
                                          viewControllerContext: viewControllerContext,
                                          dependencyProvider: dependencyProvider)
        return component.viewBuilder.makeFeatureBViewController(hasRightCloseButton: hasRightCloseButton)
    }
}
