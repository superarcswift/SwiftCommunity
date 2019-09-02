//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation

public protocol HasApplicationContext: class {
    var context: ApplicationContext! { get set }
}

public protocol HasViewControllerContext: class {
    var viewControllerContext: ViewControllerContext! { get set }
}

/// Protocol defining required depedencies used for processing application logic & driving UIs.
/// Normally every ViewController will have reference to an object adropting this protocol.
public protocol ApplicationContextProtocol: HasViewControllerContext {

    var engine: Engine { get }
    var viewControllerContext: ViewControllerContext! { get set }
}

public class ApplicationContext: ApplicationContextProtocol {

    // MARK: Properties

    // Public

    public private(set) var engine: Engine
    public var viewControllerContext: ViewControllerContext! = ViewControllerContext()

    // MARK: Initialization

    init(engine: Engine) {
        self.engine = engine
    }
}
