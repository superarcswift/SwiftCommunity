//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore
import UIKit

open class NavigationController: UINavigationController, HasApplicationContext {

    public var context: ApplicationContext! {
        didSet {
            topViewController?.setApplicationContext(context)
        }
    }

    open override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.setApplicationContext(context)
    }
}
