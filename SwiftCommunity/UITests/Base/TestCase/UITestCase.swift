//
//  Copyright © 2019 An Tran. All rights reserved.
//

import XCTest

protocol PageTestable {
    associatedtype PageType: PageObject

    var page: PageType! { get set }
}

protocol PageSnapshotable {}

class UITestCase: XCTestCase {

    enum TimeOut: Double {
        case short = 2
        case long = 10
    }

    let app = XCUIApplication()

    // MARK: Setup

    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        if self is PageSnapshotable {
            setupSnapshot(app)
        }
        app.launch()

        navigateToPage()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: APIs

    func navigateToPage() {
        fatalError("needed to be plemented")
    }
}
