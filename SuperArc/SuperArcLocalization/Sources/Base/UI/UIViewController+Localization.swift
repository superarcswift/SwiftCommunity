//
//  Copyright © 2019 An Tran. All rights reserved.
//

import UIKit

extension UIViewController {

    @IBInspectable public var titleKey: String {
        get {
            return ""
        }
        set {
            title = newValue.localized
        }
    }
}
