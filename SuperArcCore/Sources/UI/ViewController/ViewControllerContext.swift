//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

extension UIViewController {

    public func setViewControllerContext(_ context: ViewControllerContext!) {
        if let contextHolder = self as? HasViewControllerContext {
            contextHolder.context = context
        }
    }
}

public protocol HasViewControllerContext: class {
    var context: ViewControllerContext! { get set }
}

public protocol ViewControllerContext {

    var engine: Engine { get }
}

public class StandardViewControllerContext: ViewControllerContext {

    // MARK: Properties

    // Public

    public private(set) var engine: Engine

    // MARK: Initialization

    init(engine: Engine) {
        self.engine = engine
    }
}
