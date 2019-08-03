//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import XCoordinator

/// Protocol adding coordinators into ViewModels.
protocol CoordinatedViewModelProtocol {
    associatedtype RouteType: Route
    var router: AnyRouter<RouteType> { get }
}

/// Base class can be used to create ViewModels with Coordinator.
public class CoordinatedViewModel<T: Route>: ViewModel, CoordinatedViewModelProtocol {

    // MARK: Properties

    var router: AnyRouter<T>

    // MARK: Initialization

    public init(router: AnyRouter<T>, engine: Engine) {
        self.router = router
        super.init(engine: engine)
    }
}
