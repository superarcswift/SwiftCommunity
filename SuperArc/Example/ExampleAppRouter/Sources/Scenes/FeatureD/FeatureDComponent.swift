//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore

// MARK: - FeatureDComponent

class FeatureDComponent: Component<FeatureDDependency, FeatureDComponentBuilder, FeatureDInterfaceProtocol, EmptyComponentRoute> {

    public override class func register(to context: ApplicationContextProtocol, navigator: NavigatorProtocol, dependencyProvider: DependencyProvider) {
        navigator.interfaceRegistry.register(FeatureDInterface(viewControllerContext: context.viewControllerContext, dependencyProvider: dependencyProvider), for: FeatureDInterfaceProtocol.self)
    }

    func makeFeatureDViewController() -> ComponentPresentable {
        return FeatureDViewController.instantiate(with: viewControllerContext)
    }
}

// MARK: - FeatureDComponentBuilder

protocol FeatureDComponentBuilder: ViewBuildable {
    func makeFeatureDViewController() -> ComponentPresentable
}


// MARK: - FeatureDDependency

protocol FeatureDDependency: Dependency {}

protocol FeatureDInterfaceProtocol: Interface {
    func show(dependency: FeatureDDependency) -> ComponentPresentable
}

// MARK: - FeatureDInterface

class FeatureDInterface: FeatureDInterfaceProtocol {

    // MARK: Properties

    var viewControllerContext: ViewControllerContext!
    var dependencyProvider: DependencyProvider

    // MARK: Initialization

    init(viewControllerContext: ViewControllerContext, dependencyProvider: DependencyProvider) {
        self.viewControllerContext = viewControllerContext
        self.dependencyProvider = dependencyProvider
    }

    // MARK: APIs

    func show(dependency: FeatureDDependency) -> ComponentPresentable {
        let component = FeatureDComponent(dependency: dependency, viewControllerContext: viewControllerContext, dependencyProvider: dependencyProvider)
        return component.makeFeatureDViewController()
    }
}
