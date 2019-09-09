//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore

public protocol ViewControllerRoutable where Self: CommonViewControllerProtocol {
    associatedtype ComponentRouteType: ComponentRoute

    var componentsRouter: AnyComponentRouter<ComponentRouteType> { get }
}
