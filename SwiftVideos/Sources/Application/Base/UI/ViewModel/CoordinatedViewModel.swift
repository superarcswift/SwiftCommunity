//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import XCoordinator

/// Protocol adding coordinators into ViewModels.
protocol CoordinatedViewModelProtocol where Self: ViewModel {
    associatedtype RouteType: Route

    var router: AnyRouter<RouteType> { get }
}

/// Base class can be used to create ViewModels with Coordinator.
public class CoordinatedViewModel<R: Route>: ViewModel, CoordinatedViewModelProtocol {

    // MARK: Properties

    var router: AnyRouter<R>

    // MARK: Initialization

    public init(router: AnyRouter<R>, engine: Engine) {
        self.router = router
        super.init(engine: engine)
    }
}
