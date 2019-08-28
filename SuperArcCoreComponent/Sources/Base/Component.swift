//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore

public protocol ComponentProtocol: Dependency, HasApplicationContext {
    associatedtype DependencyType
    associatedtype ViewBuildableType

    /// The dependency of this component, which is should be provided by the parent of this component.
    var dependency: DependencyType { get }

    var viewBuilder: ViewBuildableType { get }
}

private class _AnyComponentBase<DependencyType, ViewBuildableType>: ComponentProtocol {

    var dependency: DependencyType {
        fatalError("need to be implemented")
    }

    var viewBuilder: ViewBuildableType {
        fatalError("need to be implemented")
    }

    var context: ApplicationContext!

    public init(dependency: DependencyType, context: ApplicationContext) {
        guard type(of: self) != _AnyComponentBase.self else {
            fatalError("Cannot initialise, must subclass")
        }
    }
}

private final class _AnyComponentBox<ConcreteComponent: ComponentProtocol>: _AnyComponentBase<ConcreteComponent.DependencyType, ConcreteComponent.ViewBuildableType> {

    var concrete: ConcreteComponent

    override var dependency: DependencyType {
        return concrete.dependency
    }

    override var viewBuilder: ViewBuildableType {
        return concrete.viewBuilder
    }

    init(_ concrete: ConcreteComponent, context: ApplicationContext) {
        self.concrete = concrete
        super.init(dependency: concrete.dependency, context: context)
    }
}

public final class AnyComponent<DependencyType, ViewBuildableType>: ComponentProtocol {

    private let box: _AnyComponentBase<DependencyType, ViewBuildableType>

    public var dependency: DependencyType {
        return box.dependency
    }

    public var viewBuilder: ViewBuildableType {
        return box.viewBuilder
    }

    public var context: ApplicationContext!

    init<Concrete: ComponentProtocol>(_ concrete: Concrete, context: ApplicationContext) where Concrete.DependencyType == DependencyType, Concrete.ViewBuildableType ==  ViewBuildableType {
        box = _AnyComponentBox(concrete, context: context)
    }
}

/// The base class of a dependency injection component containing all dependencies used by this object.
open class Component<DependencyType, ViewBuildableType>: ComponentProtocol {

    // MARK: Properties

    // Public

    public var dependency: DependencyType
    public var viewBuilder: ViewBuildableType {
        return self as! ViewBuildableType
    }

    public var context: ApplicationContext!

    // MARK: Intialization

    public init(dependency: DependencyType, context: ApplicationContext) {
        self.dependency = dependency
        self.context = context
    }
}

/// The special empty component.
public final class EmptyComponent: EmptyDependency, EmptyViewBuildable {

    // MARK: Intialization

    public init() {}
}
