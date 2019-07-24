//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore

public protocol ViewModelProtocol {
    var engine: Engine { get }
}

open class ViewModel: ViewModelProtocol {

    public let engine: Engine

    public init(engine: Engine) {
        self.engine = engine
    }
}
