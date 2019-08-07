//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation

public class ApplicationDependencyRegistry: Registry {

    // MARK: Properties

    public var container: Container<ApplicationDependency>

    // MARK: Initialization

    public init() {
        container = Container()
    }
}
