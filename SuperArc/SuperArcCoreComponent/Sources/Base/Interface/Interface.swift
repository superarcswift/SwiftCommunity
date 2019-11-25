//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore

/// Public interfaces to interact with the components.
public protocol Interface {}

/// Support creating `Interface` on-demand.
public protocol OnDemandInterface: Interface {
    init(onDemandWith componentsRouter: Navigator, viewControllerContext: ViewControllerContext, and dependencyProvider: DependencyProvider)
}

/// A special `Interface` which is empty.
public class EmptyInterface: Interface {}
