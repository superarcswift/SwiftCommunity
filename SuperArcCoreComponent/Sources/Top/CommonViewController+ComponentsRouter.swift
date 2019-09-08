//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI

extension CommonViewControllerProtocol {

    public var componentsRouter: ComponentsRouterProtocol {
        return viewControllerContext.resolve(type: ComponentsRouterProtocol.self)
    }
}
