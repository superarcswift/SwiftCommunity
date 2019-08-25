//
//  Copyright © 2019 An Tran. All rights reserved.
//

import XCTest
import Quick
import Nimble

class AuthorsPageTests: UITestCase, PageTestable {

    // MARK: Properties

    var page: AuthorsPage!

    // MARK: Setup

    override func setUp() {
        super.setUp()
        page = AuthorsPage()
    }

    override func tearDown() {
        page = nil
        super.tearDown()
    }

    override func navigateToPage() {
        XCUIApplication().tabBars.buttons["Authors"].tap()
    }

    // MARK: Tests

    func testPageIsLoaded() {
        expect(self.page.isLoaded).toEventually(beTrue())
    }
}
