//
//  Copyright © 2019 An Tran. All rights reserved.
//

import XCoordinator
import SuperArcCore
import SuperArcFoundation

public protocol ComponentRouterIdentifiable: ClassNameDerivable {}

public protocol ComponentRouter {
    associatedtype ComponentRouteType: ComponentRoute
    // TODO: add this
    //init(context: ApplicationContextProtocol)
    func trigger(_ route: ComponentRouteType) -> Presentable
}

extension ComponentRouter {
    var anyRouter: AnyComponentRouter<ComponentRouteType> {
        return AnyComponentRouter(self)
    }
}

// MARK: - Type erasure

private class _AnyComponentRouterBase<ComponentRouteType: ComponentRoute>: ComponentRouter {

    init() {
        guard type(of: self) != _AnyComponentRouterBase.self else {
            fatalError("Cannot initialise, must be subclassed")
        }
    }

    func trigger(_ route: ComponentRouteType) -> Presentable {
        fatalError("needed to be overriden")
    }
}

private final class _AnyComponentRoutableBox<ConcreteRouter: ComponentRouter>: _AnyComponentRouterBase<ConcreteRouter.ComponentRouteType> {

    var concrete: ConcreteRouter

    init(_ concrete: ConcreteRouter) {
        self.concrete = concrete
    }

    override func trigger(_ route: ComponentRouteType) -> Presentable {
        return concrete.trigger(route)
    }
}

public class AnyComponentRouter<ComponentRouteType: ComponentRoute>: ComponentRouter {

    private let box: _AnyComponentRouterBase<ComponentRouteType>

    public init<ConcreteRouter: ComponentRouter>(_ concrete: ConcreteRouter) where ConcreteRouter.ComponentRouteType == ComponentRouteType {
        self.box = _AnyComponentRoutableBox(concrete)
    }

    public func trigger(_ route: ComponentRouteType) -> Presentable {
        return box.trigger(route)
    }
}

public class AnyEmptyComponentRouter: AnyComponentRouter<EmptyComponentRoute> {

    convenience init() {
        self.init(EmptyComponentRouter())
    }
}

private class EmptyComponentRouter: ComponentRouter {
    typealias ComponentRouteType = EmptyComponentRoute

    func trigger(_ route: ComponentRouteType) -> Presentable {
        return UIViewController()
    }
}
