//
//  Copyright © 2019 An Tran. All rights reserved.
//

/// The base class for all components.
open class Component<DependencyType>: Dependency {

    // MARK: Properties

    // Public

    public let dependency: DependencyType

    // MARK: Intialization

    public init(dependency: DependencyType) {
        self.dependency = dependency
    }
}

/// The special  empty component.
open class EmptyComponent: EmptyDependency {

    // MARK: Initialization

    public init() {}
}
