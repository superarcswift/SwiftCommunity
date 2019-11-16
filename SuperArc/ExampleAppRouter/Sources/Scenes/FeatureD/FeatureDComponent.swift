//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore

// MARK: - FeatureDComponent

class FeatureDComponent: Component<FeatureDDependency, FeatureDComponentBuilder, FeatureDInterfaceProtocol, EmptyComponentRoute> {

    public override class func register(to context: ApplicationContextProtocol) {
        let componentsRouter = context.viewControllerContext.resolve(type: ComponentsRouter.self)
        componentsRouter.interfaceRegistry.register(FeatureDInterface(context: context), for: FeatureDInterfaceProtocol.self)
    }

    func makeFeatureDViewController() -> ComponentPresentable {
        return FeatureDViewController.instantiate(with: context.viewControllerContext)
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

    var context: ApplicationContextProtocol!

    init(context: ApplicationContextProtocol) {
        self.context = context
    }

    func show(dependency: FeatureDDependency) -> ComponentPresentable {
        let component = FeatureDComponent(dependency: dependency, componentsRouter: AnyEmptyComponentRouter(), context: context)
        return component.makeFeatureDViewController()
    }
}
