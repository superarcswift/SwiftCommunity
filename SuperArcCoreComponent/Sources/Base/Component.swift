//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore

public protocol ComponentProtocol: Dependency, HasApplicationContext {
    associatedtype DependencyType
    associatedtype ViewBuildableType
    associatedtype NavigationDelegateType
    associatedtype InterfaceType

    /// The dependency of this component, which is should be provided by the parent of this component.
    var dependency: DependencyType { get }

    var viewBuilder: ViewBuildableType { get }

    var navigationDelegate: NavigationDelegateType! { get }

    var interface: InterfaceType! { get }
}

/// The base class of a dependency injection component containing all dependencies used by this object.
open class Component<DependencyType, ViewBuildableType, NavigationDelegateType, InterfaceType>: ComponentProtocol {

    // MARK: Properties

    // Public

    public var dependency: DependencyType
    public var viewBuilder: ViewBuildableType {
        return self as! ViewBuildableType
    }
    public var navigationDelegate: NavigationDelegateType!
    public var interface: InterfaceType!

    public var context: ApplicationContextProtocol!

    // MARK: Intialization

    public init(dependency: DependencyType, context: ApplicationContextProtocol) {
        self.dependency = dependency
        self.context = context
    }
}

/// The special empty component.
public final class EmptyComponent: EmptyDependency, EmptyViewBuildable {

    // MARK: Intialization

    public init() {}
}
