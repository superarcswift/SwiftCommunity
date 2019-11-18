//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation

public protocol HasApplicationContext: class {
    var context: ApplicationContextProtocol! { get set }
}

public protocol HasViewControllerContext: class {
    var viewControllerContext: ViewControllerContext! { get set }
}

/// Protocol defining required depedencies used for processing application logic & driving UIs.
/// Normally every ViewController will have reference to an object adopting this protocol.
public protocol ApplicationContextProtocol: HasViewControllerContext, HasEngine {}

public class ApplicationContext: ApplicationContextProtocol {

    // MARK: Properties

    // Public

    public var engine: EngineProtocol
    public var viewControllerContext: ViewControllerContext! = ViewControllerContext()

    // MARK: Initialization

    public init(engine: EngineProtocol) {
        self.engine = engine
    }
}
