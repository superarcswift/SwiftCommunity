//
//  Copyright © 2019 An Tran. All rights reserved.
//

/// The tagging protocol for objects that serve as dependencies for components.
public protocol Dependency: AnyObject {}

/// The special dependency protocol which is empty.
public protocol EmptyDependency: Dependency {}

public final class AnyDependency<DependencyType: Dependency>: Dependency {

    /// The dependency of this component, which is should be provided by the parent of this component.
    public var dependency: DependencyType!

    public init(dependency: DependencyType) {
        self.dependency = dependency
    }

}
