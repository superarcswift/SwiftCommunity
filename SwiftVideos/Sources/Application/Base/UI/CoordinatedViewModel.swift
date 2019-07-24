//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import XCoordinator

protocol CoordinatedViewModelProtocol {
    associatedtype RouteType: Route
    var router: AnyRouter<RouteType> { get }
}

class CoordinatedViewModel<T: Route>: ViewModel, CoordinatedViewModelProtocol {

    // MARK: Properties

    var router: AnyRouter<T>

    // MARK: Initialization

    init(router: AnyRouter<T>, engine: Engine) {
        self.router = router
        super.init(engine: engine)
    }
}
