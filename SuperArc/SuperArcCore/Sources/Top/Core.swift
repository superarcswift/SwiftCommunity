//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcNetwork
import SuperArcFoundation

public class Core {

    // MARK: Properties

    // Public

    public let context: ApplicationContextProtocol

    public let engine: EngineProtocol

    // MARK: Initialization

    public init(endpoint: Endpoint, configurations: AnyRegistry<Configuration>) {

        let serviceContext = ServiceContext(endpoint: endpoint, configurations: configurations)
        engine = Engine(serviceContext: serviceContext)
        context = ApplicationContext(engine: engine)
    }

    // MARK: Private helpers
}
