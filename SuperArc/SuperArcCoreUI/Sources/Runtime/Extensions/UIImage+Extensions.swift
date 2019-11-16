//
//  Copyright © 2019 An Tran. All rights reserved.
//

import UIKit

public extension UIImage {

    class func named(_ name: String, bundleClass: AnyClass) -> UIImage? {
        return UIImage(named: name, in: Bundle(for: bundleClass), compatibleWith: nil)
    }
}
