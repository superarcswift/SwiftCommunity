//
//  Copyright © 2019 An Tran. All rights reserved.
//

import XCoordinator

//public protocol ComponentPresentable{}

public protocol ComponentRoutable {
    associatedtype ComponentRouteType: ComponentRoute

    func trigger(_ route: ComponentRoute)
}
