//
//  Copyright © 2019 An Tran. All rights reserved.
//

import XCTest

protocol PageObject {

    func isLoaded() -> Bool

    static func terminate()

}

extension PageObject {

    static func terminate() {
        XCUIApplication().terminate()
    }
}
