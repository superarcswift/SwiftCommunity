//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

public extension NSObject {

    /// Returns name of the class.
    class var className: String {
        return String(describing: self)
    }

}
