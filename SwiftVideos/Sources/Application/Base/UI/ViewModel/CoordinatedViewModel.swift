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

/// Protocol defining dependencies for a viewModel.
protocol DependencyInjectedViewModelProtocol where Self: ViewModel {
    associatedtype DependencyType
    var dependency: DependencyType { get }
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

public class DIViewModel<D>: ViewModel, DependencyInjectedViewModelProtocol {

    // MARK: Properties

    var dependency: D

    // MARK: Initialization

    public init(dependency: D, engine: Engine) {
        self.dependency = dependency
        super.init(engine: engine)
    }
}


public class CoordinatedDIViewModel<R: Route, D>: DIViewModel<D>, CoordinatedViewModelProtocol {

    // MARK: Properties

    var router: AnyRouter<R>

    // MARK: Initialization

    public init(router: AnyRouter<R>, dependency: D, engine: Engine) {
        self.router = router
        super.init(dependency: dependency, engine: engine)
    }
}