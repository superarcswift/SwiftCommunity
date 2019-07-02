//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation

public class ServiceRegistry: Registry {

    public var container: Container<Service>

    public init() {
        container = Container()
    }
}
