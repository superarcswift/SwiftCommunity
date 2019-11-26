//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore

// MARK: - FeatureAComponent

/// Main component class.
public class FeatureAComponent: Component<FeatureADependency, FeatureAComponentBuilder, FeatureAInterfaceProtocol, EmptyComponentRoute>, FeatureAComponentBuilder {

    public override class func register(to context: ApplicationContextProtocol, navigator: NavigatorProtocol, dependencyProvider: DependencyProvider) {
        navigator.interfaceRegistry.register(FeatureAInterface(viewControllerContext: context.viewControllerContext, dependencyProvider: dependencyProvider), for: FeatureAInterfaceProtocol.self)
    }

    public func makeFeatureAViewController(hasRightCloseButton: Bool = false) -> ComponentPresentable {
        let viewController = FeatureAViewController.instantiate(with: viewControllerContext)
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

/// Protocol defining methods for outside components to interact with this component.
public protocol FeatureAInterfaceProtocol: Interface {
    func show(dependency: FeatureADependency, hasRightCloseButton: Bool) -> ComponentPresentable
}

public class FeatureAInterface: FeatureAInterfaceProtocol {

    // MARK: Properties

    public var viewControllerContext: ViewControllerContext!
    public var dependencyProvider: DependencyProvider

    // MARK: Initialization

    public init(viewControllerContext: ViewControllerContext, dependencyProvider: DependencyProvider) {
        self.viewControllerContext = viewControllerContext
        self.dependencyProvider = dependencyProvider
    }

    // MARK: APIs

    public func show(dependency: FeatureADependency, hasRightCloseButton: Bool = false) -> ComponentPresentable {
        let component = FeatureAComponent(dependency: dependency, viewControllerContext: viewControllerContext, dependencyProvider: dependencyProvider)
        return component.makeFeatureAViewController(hasRightCloseButton: hasRightCloseButton)
    }
}
