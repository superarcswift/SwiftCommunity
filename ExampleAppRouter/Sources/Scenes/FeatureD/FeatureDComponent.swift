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
    func show(dependency: FeatureDDependency, context: ApplicationContextProtocol) -> ComponentPresentable
}

class FeatureDComponent: Component<FeatureDDependency, FeatureDComponentBuilder, FeatureDInterfaceProtocol, EmptyComponentRoute> {

    func makeFeatureDViewController() -> ComponentPresentable {
        return FeatureDViewController.instantiate(with: context.viewControllerContext)
    }
}

// MARK: - AuthorsInterface

class FeatureDInterface: FeatureDInterfaceProtocol {

    init() {}

    func show(dependency: FeatureDDependency, context: ApplicationContextProtocol) -> ComponentPresentable {
        return FeatureDComponent(dependency: dependency, componentsRouter: AnyEmptyComponentRouter(), context: context).makeFeatureDViewController()
    }
}
