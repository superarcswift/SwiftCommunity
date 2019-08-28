//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore

public protocol ComponentProtocol: Dependency, HasApplicationContext {
    associatedtype DependencyType

    /// The dependency of this component, which is should be provided by the parent of this component.
    var dependency: DependencyType { get }
}

private class _AnyComponentBase<DependencyType>: ComponentProtocol {

    var dependency: DependencyType {
        fatalError("need to be implemented")
    }
    var context: ApplicationContext!

    public init(dependency: DependencyType, context: ApplicationContext) {
        guard type(of: self) != _AnyComponentBase.self else {
            fatalError("Cannot initialise, must subclass")
        }
    }
}

private final class _AnyComponentBox<ConcreteComponent: ComponentProtocol>: _AnyComponentBase<ConcreteComponent.DependencyType> {

    var concrete: ConcreteComponent

    override var dependency: DependencyType {
        return concrete.dependency
    }

    init(_ concrete: ConcreteComponent, context: ApplicationContext) {
        self.concrete = concrete
        super.init(dependency: concrete.dependency, context: context)
    }
}

public final class AnyComponent<DependencyType>: ComponentProtocol {

    private let box: _AnyComponentBase<DependencyType>

    public var dependency: DependencyType {
        return box.dependency
    }

    public var context: ApplicationContext!

    init<Concrete: ComponentProtocol>(_ concrete: Concrete, context: ApplicationContext) where Concrete.DependencyType == DependencyType {
        box = _AnyComponentBox(concrete, context: context)
    }
}

/// The base class of a dependency injection component containing all dependencies used by this object.
open class Component<DependencyType>: ComponentProtocol {

    // MARK: Properties

    // Public

    public var dependency: DependencyType
    public var context: ApplicationContext!

    // MARK: Intialization

    public init(dependency: DependencyType, context: ApplicationContext) {
        self.dependency = dependency
        self.context = context
    }
}

/// The special empty component.
public class EmptyComponent: EmptyDependency {

    // MARK: Intialization

    public init() {}
}
