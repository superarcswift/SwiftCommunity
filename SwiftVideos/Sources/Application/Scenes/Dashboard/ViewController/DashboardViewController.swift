//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation

class DashboardViewController: TabBarController, StoryboardInitiable {

    static var storyboardName = "Dashboard"

    // MARK: Setup

    override func setupViews() {
        super.setupViews()
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(item)
    }
}

extension DashboardViewController {

    var conferencesRootViewController: NavigationController {
        return rootViewController(with: ConferencesCollectionViewController.self)
    }

    var videosRootViewController: NavigationController {
        return rootViewController(with: VideosCollectionViewController.self)
    }

    var authorsRootViewController: NavigationController {
        return rootViewController(with: AuthorCollectionViewController.self)
    }

    var moreRootViewController: NavigationController {
        return rootViewController(with: MoreTableViewController.self)
    }

    private func rootViewController(with type: UIViewController.Type) -> NavigationController {
        let filter = children.filter { viewController in
            guard ((viewController as? NavigationController)?.topViewController as? ConferencesCollectionViewController) != nil else {
                return false
            }

            return true
        }

        guard let navigationController = filter.first as? NavigationController else {
            fatalError("conferences controller not found")
        }

        return navigationController
    }
}
