//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation

public protocol HasViewControllerContext: class {
    var context: ViewControllerContext! { get set }
}

public protocol ViewControllerContext: Dependency {

    var engine: Engine { get }
    var dependencyRegistry: ViewControllerDependencyRegistry { get }
}

public class StandardViewControllerContext: ViewControllerContext {

    // MARK: Properties

    // Public

    public private(set) var engine: Engine
    public let dependencyRegistry = ViewControllerDependencyRegistry()

    // Private

    // MARK: Initialization

    init(engine: Engine) {
        self.engine = engine
    }
}
