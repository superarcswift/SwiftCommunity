//
//  Copyright © 2019 An Tran. All rights reserved.
//

import XCTest

class VideosPage: PageObject {

    var loadedElement: XCUIElement {
        return XCUIApplication().navigationBars["Videos"].otherElements["Videos"]
    }
}
