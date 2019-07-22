//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore

public protocol ViewModelBindable {
    associatedtype ViewModelType: ViewModelProtocol

    var storedViewModel: ViewModelType? { get set }

    func setupViewModel() -> ViewModelType!
    func setupBindings()
}

public protocol ViewModelProtocol {
    var engine: Engine { get }
}

open class ViewModel: ViewModelProtocol {

    public let engine: Engine

    public init(engine: Engine) {
        self.engine = engine
    }
}
