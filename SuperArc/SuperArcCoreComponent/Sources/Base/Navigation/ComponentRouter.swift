//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore
import SuperArcFoundation

public protocol ComponentRouterIdentifiable: ClassNameDerivable {}

public protocol ComponentRouter: ComponentRouterIdentifiable {
    associatedtype ComponentRouteType: ComponentRoute

    func trigger(_ route: ComponentRouteType) -> ComponentPresentable?
}

// MARK: - Type erasure

private class _AnyComponentRouterBase<ComponentRouteType: ComponentRoute>: ComponentRouter {

    init() {
        guard type(of: self) != _AnyComponentRouterBase.self else {
            fatalError("Cannot initialise, must be subclassed")
        }
    }

    func trigger(_ route: ComponentRouteType) -> ComponentPresentable? {
        fatalError("needed to be overriden")
    }
}

private final class _AnyComponentRoutableBox<ConcreteRouter: ComponentRouter>: _AnyComponentRouterBase<ConcreteRouter.ComponentRouteType> {

    var concrete: ConcreteRouter

    init(_ concrete: ConcreteRouter) {
        self.concrete = concrete
    }

    override func trigger(_ route: ComponentRouteType) -> ComponentPresentable? {
        return concrete.trigger(route)
    }
}

public class AnyComponentRouter<ComponentRouteType: ComponentRoute>: ComponentRouter {

    private let box: _AnyComponentRouterBase<ComponentRouteType>

    public init<ConcreteRouter: ComponentRouter>(_ concrete: ConcreteRouter) where ConcreteRouter.ComponentRouteType == ComponentRouteType {
        self.box = _AnyComponentRoutableBox(concrete)
    }

    public func trigger(_ route: ComponentRouteType) -> ComponentPresentable? {
        return box.trigger(route)
    }
}

// MARK: - EmptyComponentRouter

public class AnyEmptyComponentRouter: AnyComponentRouter<EmptyComponentRoute> {

    public convenience init() {
        self.init(EmptyComponentRouter())
    }
}

private class EmptyComponentRouter: ComponentRouter {
    typealias ComponentRouteType = EmptyComponentRoute

    func trigger(_ route: ComponentRouteType) -> ComponentPresentable? {
        return nil
    }
}
