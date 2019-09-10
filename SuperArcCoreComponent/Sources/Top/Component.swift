//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore

public protocol ComponentProtocol: Dependency, HasApplicationContext, ComponentRouter {
    associatedtype DependencyType
    associatedtype ViewBuildableType
    associatedtype InterfaceType

    /// The dependency of this component, which is should be provided by the parent of this component.
    var dependency: DependencyType { get }

    var viewBuilder: ViewBuildableType { get }

    var interface: InterfaceType! { get }

    /// Register any objects provided by this component that will be used by classes in the higher layer.
    static func register(to context: ApplicationContextProtocol)
}

/// The base class of a dependency injection component containing all dependencies used by this object.
open class Component<DependencyType, ViewBuildableType, InterfaceType, ComponentRouteType: ComponentRoute>: ComponentProtocol {

    // MARK: Properties

    // Public

    public var dependency: DependencyType

    public var viewBuilder: ViewBuildableType {
        return self as! ViewBuildableType
    }

    public var componentsRouter: AnyComponentRouter<ComponentRouteType>?

    public var interface: InterfaceType!

    public var context: ApplicationContextProtocol!

    // MARK: Intialization

    public init(dependency: DependencyType, componentsRouter: AnyComponentRouter<ComponentRouteType>? = nil, context: ApplicationContextProtocol) {
        self.dependency = dependency
        self.context = context
        self.componentsRouter = componentsRouter
    }

    // MARK: APIs

    open class func register(to context: ApplicationContextProtocol) {
        fatalError("needed to be implemented")
    }

    open func trigger(_ route: ComponentRouteType) -> ComponentPresentable? {
        fatalError("needed to be implemented")
    }
}

extension Component where ComponentRouteType == EmptyComponentRoute {
    public convenience init(dependency: DependencyType, context: ApplicationContextProtocol) {
        self.init(dependency: dependency, componentsRouter: AnyEmptyComponentRouter(), context: context)
    }
}

/// The special empty component.
public final class EmptyComponent: EmptyDependency, EmptyViewBuildable {

    // MARK: Intialization

    public init() {}
}
