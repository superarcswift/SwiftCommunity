//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import XCoordinator

typealias MoreDependency = HasGitService

/// Protocol used to mock for testing purpose.
protocol MoreBuilder {
    func makeMoreTableViewController(router: AnyRouter<MoreRoute>) -> MoreTableViewController
}

class MoreComponent: Component<MoreDependency>, MoreBuilder {

    // MARK: APIs

    func makeMoreTableViewController(router: AnyRouter<MoreRoute>) -> MoreTableViewController {
        let viewController = MoreTableViewController.instantiate(with: context)
        let viewModel = MoreViewModel(router: router, dependency: dependency)
        viewController.viewModel = viewModel
        return viewController
    }
}
