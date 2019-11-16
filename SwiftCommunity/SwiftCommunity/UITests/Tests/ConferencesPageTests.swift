//
//  Copyright © 2019 An Tran. All rights reserved.
//

import XCTest
import Quick
import Nimble

class ConferencesPageTests: UITestCase, PageTestable, PageSnapshotable {

    var page: ConferencesPage!

    override func setUp() {
        super.setUp()
        page = ConferencesPage()
    }

    override func tearDown() {
        page = nil
        super.tearDown()
    }

    override func navigateToPage() {}

    // MARK: Tests

    func testPageIsLoaded() {
        expect(self.page.isLoaded).toEventually(beTrue())
        snapshot("01_ConferencesScreen")
    }
}
