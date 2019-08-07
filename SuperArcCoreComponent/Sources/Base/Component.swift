//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore

/// The base class of a dependency injection component.
open class Component<DependencyType>: Dependency, HasApplicationContext {

    // MARK: Properties

    // Public

    /// The dependency of this component, which is should be provided by the parent of this component.
    public private(set) var dependency: DependencyType!

    /// Context used to provide dependencies to children.
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
