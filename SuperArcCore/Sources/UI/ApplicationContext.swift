//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation

public protocol HasApplicationContext: class {
    var context: ApplicationContext! { get }
}

public protocol ApplicationContextProtocol {

    var engine: Engine { get }
    var dependencyRegistry: ApplicationDependencyRegistry { get }
}

public class ApplicationContext: ApplicationContextProtocol {

    // MARK: Properties

    // Public

    public private(set) var engine: Engine
    public let dependencyRegistry = ApplicationDependencyRegistry()

    // Private

    // MARK: Initialization

    init(engine: Engine) {
        self.engine = engine
    }
}
