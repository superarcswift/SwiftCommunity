//
//  Copyright © 2019 An Tran. All rights reserved.
//

import UIKit

extension UILabel {
    @IBInspectable public var textKey: String? {
        get {
            return accessibilityIdentifier
        }
        set {
            accessibilityIdentifier = newValue
            text = newValue?.localized
        }
    }
}
