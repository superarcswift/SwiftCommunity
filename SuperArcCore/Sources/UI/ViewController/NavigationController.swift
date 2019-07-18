//
//  Copyright © 2019 An Tran. All rights reserved.
//

import UIKit

open class NavigationController: UINavigationController, HasViewControllerContext {

    public var context: ViewControllerContextProtocol! {
        didSet {
            topViewController?.setViewControllerContext(context)
        }
    }

    open override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.setViewControllerContext(context)
    }
}
