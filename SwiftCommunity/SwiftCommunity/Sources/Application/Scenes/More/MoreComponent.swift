//
//  Copyright © 2019 An Tran. All rights reserved.
//

import CoreUX
import Core
import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import XCoordinator

typealias MoreDependency = HasGitService

/// Protocol used to mock for testing purpose.
protocol MoreViewBuilder: ViewBuildable {
    func makeMoreTableViewController(router: UnownedRouter<MoreRoute>) -> UIViewController
    func makeOpenConferencesViewController(router: UnownedRouter<MoreRoute>) -> UIViewController
    func makeAboutViewController(router: UnownedRouter<MoreRoute>) -> UIViewController
    func makeContentLicensesViewController(router: UnownedRouter<MoreRoute>) -> UIViewController
}

class MoreComponent: Component<MoreDependency, MoreViewBuilder, EmptyInterface, EmptyComponentRoute>, MoreViewBuilder {

    // MARK: APIs

    func makeMoreTableViewController(router: UnownedRouter<MoreRoute>) -> UIViewController {
        let viewController = MoreTableViewController.instantiate(with: viewControllerContext)
        let viewModel = MoreViewModel(router: router, dependency: dependency)
        viewController.viewModel = viewModel
        return viewController
    }

    func makeOpenConferencesViewController(router: UnownedRouter<MoreRoute>) -> UIViewController {
        let viewController = OpenConferencesViewController.instantiate(with: viewControllerContext)
        let viewModel = OpenConferencesViewModel(dependency: dependencyProvider.context)
        viewController.viewModel = viewModel
        return viewController
    }

    func makeAboutViewController(router: UnownedRouter<MoreRoute>) -> UIViewController {
        let path = Bundle.main.path(forResource: "README", ofType: "md")!
        let contentURL = URL(fileURLWithPath: path)

        let viewController = AboutViewController.instantiate(with: viewControllerContext)
        let viewModel = MarkdownViewModel(resourceURL: contentURL)
        viewController.viewModel = viewModel
        return viewController
    }

    func makeContentLicensesViewController(router: UnownedRouter<MoreRoute>) -> UIViewController {
        let contentURL = dependency.gitService.localURL(for: "LICENSE")
        let viewController = LicensesViewController.instantiate(with: viewControllerContext)
        viewController.viewModel = MarkdownViewModel(resourceURL: contentURL)
        return viewController
    }

}
