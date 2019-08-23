//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore
import UIKit

extension UIViewController {

    public func setViewControllerContext(_ context: ViewControllerContext) {
        if let contextHolder = self as? HasViewControllerContext {
            contextHolder.viewControllerContext = context
        }
    }
}

