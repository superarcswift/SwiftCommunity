//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI

class DashboardViewController: ViewController<DashboardViewModel>, StoryboardInitiable {
    static var storyboardName = "Dashboard"

    override func loadData() {
        super.loadData()

        viewModel.loadData()
    }
}
