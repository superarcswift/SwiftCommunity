//
//  Copyright © 2019 An Tran. All rights reserved.
//

import UIKit

extension UIViewController {

    public func setViewControllerContext(_ context: ViewControllerContextProtocol!) {
        if let contextHolder = self as? HasViewControllerContext {
            contextHolder.context = context
        }
    }
}

