//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import XCoordinator

/// Protocol used to mock for testing purpose.
protocol MoreBuilder {
    func makeMoreTableViewController() -> MoreTableViewController
}

class MoreComponent: Component<EmptyDependency>, MoreBuilder {

    // MARK: APIs

    func makeMoreTableViewController() -> MoreTableViewController {
        let viewController = MoreTableViewController.instantiate(with: context)
        return viewController
    }
}
