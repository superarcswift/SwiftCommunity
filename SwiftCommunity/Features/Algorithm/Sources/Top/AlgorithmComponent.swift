//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import DataModels
import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import UIKit

// MARK: - AlgorithmComponent

public class AlgorithmComponent: Component<AlgorithmDependency, AlgorithmViewBuilder, EmptyInterface, EmptyComponentRoute>, AlgorithmViewBuilder {

    // MARK: APIs

    public func makeDashboardViewController() -> UIViewController {
        let viewController = DashboardTableViewController.instantiate(with: viewControllerContext)
        viewController.delegate = self
        viewController.viewModel = DashboardViewModel(dependency: dependency)
        return viewController
    }
}

// MARK: - AlgorithmViewBuilder

public protocol AlgorithmViewBuilder: ViewBuildable {
    func makeDashboardViewController() -> UIViewController
}

// MARK: - DashbardNavigationDelegate

extension AlgorithmComponent: DashboardNavigationDelegate {
    func show(_ sectionID: String?, from navigationController: UINavigationController?) {
        let viewController = makeDashboardViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
