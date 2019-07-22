//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import RxSwift

class DashboardViewController: TabBarController, StoryboardInitiable {

    static var storyboardName = "Dashboard"

    var didSelect = PublishSubject<DashboardTabItem>()

    // MARK: Setup

    override func setupViews() {
        super.setupViews()
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let tabItem = DashboardTabItem(rawValue: item.tag) else {
            return
        }
        didSelect.on(.next(tabItem))
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
        return rootViewController(with: AuthorsCollectionViewController.self)
    }

    var moreRootViewController: NavigationController {
        return rootViewController(with: MoreTableViewController.self)
    }

    private func rootViewController<T>(with type: T.Type) -> NavigationController {
        let filter = children.filter { viewController in
            guard ((viewController as? NavigationController)?.topViewController as? T) != nil else {
                return false
            }

            return true
        }

        guard let navigationController = filter.first as? NavigationController else {
            fatalError("top controller not found")
        }

        return navigationController
    }
}

enum DashboardTabItem: Int {
    case conferences
    case videos
    case authors
    case more
}
