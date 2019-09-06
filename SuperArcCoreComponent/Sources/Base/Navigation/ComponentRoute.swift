//
//  Copyright © 2019 An Tran. All rights reserved.
//

import XCoordinator

/// Protocol defining routes that a component can navigate to.
public protocol ComponentRoute {}

public enum EmptyComponentRoute: ComponentRoute {}

public protocol ComponentRouter {
    associatedtype ComponentRouteType: ComponentRoute

    func trigger(_ route: ComponentRouteType) -> Presentable
}
