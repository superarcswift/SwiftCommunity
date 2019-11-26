//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore

protocol FeatureDComponentBuilder: ViewBuildable {
    func makeFeatureDViewController() -> ComponentPresentable
}

protocol FeatureDDependency: Dependency {
}

protocol FeatureDInterfaceProtocol: Interface {
    func show(dependency: FeatureDDependency) -> ComponentPresentable
}

class FeatureDComponent: Component<FeatureDDependency, FeatureDComponentBuilder, FeatureDInterfaceProtocol, EmptyComponentRoute> {

    public override class func register(to context: ApplicationContextProtocol, navigator: NavigatorProtocol, dependencyProvider: DependencyProvider) {
        let interface = FeatureDInterface(viewControllerContext: context.viewControllerContext, dependencyProvider: dependencyProvider)
        navigator.interfaceRegistry.register(interface, for: FeatureDInterfaceProtocol.self)
    }

    func makeFeatureDViewController() -> ComponentPresentable {
        return FeatureDViewController.instantiate(with: viewControllerContext)
    }
}

// MARK: - AuthorsInterface

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
