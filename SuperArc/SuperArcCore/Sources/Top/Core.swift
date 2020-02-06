//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcNetwork
import SuperArcFoundation

public class Core: HasApplicationContext {

    // MARK: Properties

    // Public

    public var context: ApplicationContextProtocol!

    // MARK: Initialization

    public init(endpoint: Endpoint, configurations: AnyRegistry<Configuration>) {
        let serviceContext = ServiceContext(endpoint: endpoint, configurations: configurations)
        let engine = Engine(serviceContext: serviceContext)
        context = ApplicationContext(engine: engine)
    }
}
