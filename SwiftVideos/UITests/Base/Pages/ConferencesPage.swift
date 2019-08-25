//
//  Copyright © 2019 An Tran. All rights reserved.
//

import XCTest

class ConferencesPage: PageObject {

    var loadedElement: XCUIElement {
        return XCUIApplication().navigationBars["Conferences"].otherElements["Conferences"]
    }
}
