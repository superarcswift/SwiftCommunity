//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

open class NavigationController: UINavigationController, HasViewControllerContext {

    open var context: ViewControllerContext! {
        didSet {
            topViewController?.setViewControllerContext(context)
        }
    }

    open override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.setViewControllerContext(context)
    }
}
