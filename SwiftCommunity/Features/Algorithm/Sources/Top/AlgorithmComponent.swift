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

        let viewController = DashboardViewController.instantiate(with: viewControllerContext)
        viewController.viewModel = DashboardViewModel(dependency: dependency)
        return viewController
    }
}

// MARK: - AlgorithmViewBuilder

public protocol AlgorithmViewBuilder: ViewBuildable {
    func makeDashboardViewController() -> UIViewController
}
