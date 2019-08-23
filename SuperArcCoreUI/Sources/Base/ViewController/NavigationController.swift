//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore
import UIKit

open class NavigationController: UINavigationController, HasViewControllerContext {

    public var viewControllerContext: ViewControllerContext! {
        didSet {
            topViewController?.setViewControllerContext(viewControllerContext)
        }
    }

    open override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.setViewControllerContext(viewControllerContext)
    }
}
