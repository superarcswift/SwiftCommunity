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

    public var unownedViewBuilder: UnownedWrapper<AlgorithmComponent> {
        return UnownedWrapper(self)
    }

    // MARK: APIs

    public func makeDashboardViewController(forSection sectionID: String?, with builder: UnownedWrapper<AlgorithmComponent>?) -> UIViewController {
        let viewController = ContentTableViewController.instantiate(with: viewControllerContext)
        viewController.builder = builder
        viewController.sectionID = sectionID
        viewController.viewModel = ContentViewModel(dependency: dependency)
        return viewController
    }
}

// MARK: - AlgorithmViewBuilder

public protocol AlgorithmViewBuilder: ViewBuildable {
    func makeDashboardViewController(forSection sectionID: String?, with builder: UnownedWrapper<AlgorithmComponent>?) -> UIViewController
}
