//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI

extension CommonViewControllerProtocol {

    public var storedComponentsRouter: NavigatorProtocol {
        return viewControllerContext.resolve(type: Navigator.self)
    }
}
