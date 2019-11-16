//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation

public class ViewControllerContext: Registry {

    // MARK: Properties

    public var container: Container<ViewControllerDependency>

    // MARK: Initialization

    public init() {
        container = Container()
    }
}
