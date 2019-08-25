//
//  Copyright © 2019 An Tran. All rights reserved.
//

import XCTest

class AuthorsPage: PageObject {

    var loadedElement: XCUIElement {
        return XCUIApplication().navigationBars["Authors"].otherElements["Authors"]
    }
}
