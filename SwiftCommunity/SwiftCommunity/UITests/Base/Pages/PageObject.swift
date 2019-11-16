//
//  Copyright © 2019 An Tran. All rights reserved.
//

import XCTest

protocol PageObject {

    var loadedElement: XCUIElement { get }

    var isLoaded: Bool { get }

    static func terminate()

}

extension PageObject {

    var isLoaded: Bool {
        return loadedElement.isDisplayed
    }

    static func terminate() {
        XCUIApplication().terminate()
    }
}
