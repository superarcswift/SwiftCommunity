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

// MARK: - AuthorsComponent

public class AlgorithmComponent: Component<EmptyDependency, AlgorithmViewBuilder, EmptyInterface, EmptyComponentRoute>, AlgorithmViewBuilder {

    // MARK: APIs

    public func makeDashboardViewController() -> UIViewController {

        let viewController = DashboardViewController.instantiate(with: viewControllerContext)
        return viewController
    }
}

// MARK: - AuthorsViewBuilder

public protocol AlgorithmViewBuilder: ViewBuildable {
    func makeDashboardViewController() -> UIViewController
}
