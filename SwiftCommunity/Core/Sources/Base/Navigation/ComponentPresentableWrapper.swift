//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import XCoordinator

// Wrapper to abstract XCoordinator's specific implementation.
public struct ComponentPresentableWrapper: ComponentPresentable {

    // MARK: Properties

    // Public

    public var presentable: Presentable

    public var viewController: UIViewController! {
        return presentable.viewController
    }

    // MARK: Initialization

    public init(presentable: Presentable) {
        self.presentable = presentable
    }
}
