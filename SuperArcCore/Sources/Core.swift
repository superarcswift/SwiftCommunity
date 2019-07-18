//
//  Copyright © 2019 An Tran. All rights reserved.
//


public class Core {

    // MARK: Properties

    // Public

    public var viewControllerContext: ViewControllerContext

    public var engine: Engine

    // MARK: Initialization

    public init() {
        let serviceContext = ServiceContext()
        engine = Engine(serviceContext: serviceContext)

        viewControllerContext = ViewControllerContext(engine: engine)
    }
}
