//
//  Copyright © 2019 An Tran. All rights reserved.
//

import XCTest

extension XCUIElement {
    var isDisplayed: Bool {
        return self.exists && self.isHittable
    }
}
