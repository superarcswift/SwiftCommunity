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

    public var unonwedViewBuilder: UnonwedWrapper<AlgorithmComponent> {
        return UnonwedWrapper(self)
    }

    // MARK: APIs

    public func makeDashboardViewController(with builder: UnonwedWrapper<AlgorithmComponent>?) -> UIViewController {
        let viewController = DashboardTableViewController.instantiate(with: viewControllerContext)
        viewController.builder = builder
        viewController.viewModel = DashboardViewModel(dependency: dependency)
        return viewController
    }
}

// MARK: - AlgorithmViewBuilder

public protocol AlgorithmViewBuilder: ViewBuildable {
    func makeDashboardViewController(with builder: UnonwedWrapper<AlgorithmComponent>?) -> UIViewController
}
