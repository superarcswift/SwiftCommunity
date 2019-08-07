//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore
import UIKit

extension UIViewController {

    public func setApplicationContext(_ context: ApplicationContext) {
        if let contextHolder = self as? HasApplicationContext {
            contextHolder.context = context
        }
    }
}

