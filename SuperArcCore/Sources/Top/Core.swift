//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation

public class Core {

    // MARK: Properties

    // Public

    public var context: ApplicationContextProtocol

    public var engine: EngineProtocol

    public var configurations: AnyRegistry<Configuration>

    // MARK: Initialization

    public init(configurations: AnyRegistry<Configuration>) {
        self.configurations = configurations

        let serviceContext = ServiceContext()
        engine = Engine(serviceContext: serviceContext)
        context = ApplicationContext(engine: engine)
    }
}
