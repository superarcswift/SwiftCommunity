//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import XCoordinator

typealias MoreDependency = HasGitService

/// Protocol used to mock for testing purpose.
protocol MoreViewBuilder: ViewBuildable {
    func makeMoreTableViewController(router: AnyRouter<MoreRoute>) -> MoreTableViewController
    func makeAboutViewController(router: AnyRouter<MoreRoute>) -> AboutViewController
    func makeLicensesViewController(router: AnyRouter<MoreRoute>) -> LicensesViewController
}

class MoreComponent: Component<MoreDependency, MoreViewBuilder>, MoreViewBuilder {

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

    func makeLicensesViewController(router: AnyRouter<MoreRoute>) -> LicensesViewController {
        let viewController = LicensesViewController.instantiate(with: context.viewControllerContext)
        return viewController
    }

}
