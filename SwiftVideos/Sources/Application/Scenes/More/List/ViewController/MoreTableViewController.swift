//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import UIKit

class MoreTableViewController: TableViewController, StoryboardInitiable {

    // MAK: Properties

    // Static

    static var storyboardName = "More"

    // MARK: Overrides

    override func setupViews() {
        super.setupViews()

        tableView.rowHeight = Constants.UI.defaultRowHeight
        tableView.tableFooterView = UIView(frame: .zero)
    }
}
