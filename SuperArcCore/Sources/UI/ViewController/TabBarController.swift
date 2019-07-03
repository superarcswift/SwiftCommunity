//
//  Copyright © 2019 An Tran. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, HasViewControllerContext {

    // MARK: Properties

    var context: ViewControllerContext!

    // MARK: Initialization

    init(context: ViewControllerContext) {
        super.init(nibName: nil, bundle: nil)
        self.context = context
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: Overwritten

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let viewControllers = viewControllers else {
            return
        }

        for viewController in viewControllers {
            viewController.setViewControllerContext(context)
        }
    }

}

// MARK: - UITabBarControllerDelegate

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        viewController.setViewControllerContext(context)
    }
}
