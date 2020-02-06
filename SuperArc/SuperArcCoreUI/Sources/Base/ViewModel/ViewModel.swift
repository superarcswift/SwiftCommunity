//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore

public protocol ViewModelProtocol {}

open class ViewModel: ViewModelProtocol {

    // MARK: Initialization

    public init() {
        setup()
    }

    open func setup() {
        // Override if you want to setup this viewModel such as data bindings etc...
    }
}
