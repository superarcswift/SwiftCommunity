//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

public protocol HasViewControllerContext: class {
    var context: ViewControllerContextProtocol! { get set }
}

public protocol ViewControllerContextProtocol {

    var engine: Engine { get }
}

public class ViewControllerContext: ViewControllerContextProtocol {

    // MARK: Properties

    // Public

    public private(set) var engine: Engine

    // MARK: Initialization

    init(engine: Engine) {
        self.engine = engine
    }
}
