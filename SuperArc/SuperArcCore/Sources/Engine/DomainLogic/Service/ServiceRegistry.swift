//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation

public class ServiceRegistry: Registry {

    // MARK: Properties

    public var container: Container<Service>

    // MARK: Initialization

    public init() {
        container = Container()
    }
}
