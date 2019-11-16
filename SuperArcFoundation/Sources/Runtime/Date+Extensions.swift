//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

extension Date {

    public var currentYear: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: self)
        return components.year!
    }
}
