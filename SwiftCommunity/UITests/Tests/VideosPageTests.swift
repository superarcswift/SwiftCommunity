//
//  Copyright © 2019 An Tran. All rights reserved.
//

import XCTest
import Quick
import Nimble

class VideosPageTests: UITestCase, PageTestable, PageSnapshotable {

    // MARK: Properties

    var page: VideosPage!

    // MARK: Setup

    override func setUp() {
        super.setUp()
        page = VideosPage()
    }

    override func tearDown() {
        page = nil
        super.tearDown()
    }

    override func navigateToPage() {
        XCUIApplication().tabBars.buttons["Videos"].tap()
    }

    // MARK: Tests

    func testPageIsLoaded() {
        expect(self.page.isLoaded).toEventually(beTrue())
        snapshot("02VideosScreen")
    }
}
