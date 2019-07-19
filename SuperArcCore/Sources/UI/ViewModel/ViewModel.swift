//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

public protocol ViewModelProtocol {
    var engine: Engine { get }
}

open class ViewModel: NSObject, ViewModelProtocol {

    public let engine: Engine

    public init(engine: Engine) {
        self.engine = engine
    }
}
