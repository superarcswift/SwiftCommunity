//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore

protocol FeatureCComponentBuilder: ViewBuildable {
    func makeFeatureCViewController(hasRightCloseButton: Bool) -> ComponentPresentable
}

protocol FeatureCDependency: Dependency {}

protocol FeatureCInterfaceProtocol: Interface {
    func show(dependency: FeatureCDependency, hasRightCloseButton: Bool) -> ComponentPresentable
}

class FeatureCComponent: Component<FeatureCDependency, FeatureCComponentBuilder, FeatureCInterfaceProtocol, EmptyComponentRoute> {

    public override class func register(to context: ApplicationContextProtocol, navigator: NavigatorProtocol, dependencyProvider: DependencyProvider) {
        navigator.interfaceRegistry.register(FeatureCInterface(viewcontrollerContext: context.viewControllerContext, dependencyProvider: dependencyProvider), for: FeatureCInterfaceProtocol.self)
    }

    func makeFeatureCViewController(hasRightCloseButton: Bool = false) -> ComponentPresentable {
        let viewController = FeatureCViewController.instantiate(with: viewControllerContext)
        viewController.hasRightCloseButton = hasRightCloseButton
        let navigationController = NavigationController(rootViewController: viewController)
        return navigationController
    }
}

// MARK: - AuthorsInterface

class FeatureCInterface: FeatureCInterfaceProtocol {

    // MARK: Properties

    var viewControllerContext: ViewControllerContext!
    var dependencyProvider: DependencyProvider

    // MARK: Initialization

    init(viewcontrollerContext: ViewControllerContext, dependencyProvider: DependencyProvider) {
        self.viewControllerContext = viewcontrollerContext
        self.dependencyProvider = dependencyProvider
    }

    // MARK: APIs

    func show(dependency: FeatureCDependency, hasRightCloseButton: Bool = false) -> ComponentPresentable {
        let component = FeatureCComponent(dependency: dependency, router: AnyEmptyComponentRouter(), viewControllerContext: viewControllerContext, dependencyProvider: dependencyProvider)
        return component.makeFeatureCViewController(hasRightCloseButton: hasRightCloseButton)
    }
}
