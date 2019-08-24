//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SwiftVideos_Core
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
        let viewController = MoreTableViewController.instantiate(with: context.viewControllerContext)
        let viewModel = MoreViewModel(router: router, dependency: dependency)
        viewController.viewModel = viewModel
        return viewController
    }

    func makeAboutViewController(router: AnyRouter<MoreRoute>) -> AboutViewController {
        let viewController = AboutViewController.instantiate(with: context.viewControllerContext)
        let viewModel = AboutViewModel()
        viewController.viewModel = viewModel
        return viewController
    }

}
