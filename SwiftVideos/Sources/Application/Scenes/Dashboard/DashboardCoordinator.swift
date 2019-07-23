//
//  Copyright © 2019 An Tran. All rights reserved.
//

import XCoordinator
import SuperArcCoreUI
import SuperArcCore
import RxSwift
import UIKit

class DashboardCoordinator: TabBarCoordinator<DashboardRoute> {

    // MARK: Properties

    // Private

    private var viewControllerContext: ViewControllerContext
    private let conferencesRouter: AnyRouter<ConferencesRoute>
    private let videosRouter: AnyRouter<VideosRoute>

    // MARK: Initialization

    convenience init(viewControllerContext: ViewControllerContext) {
        let conferencesCoordinator = ConferencesCoordinator(viewControllerContext: viewControllerContext)
        conferencesCoordinator.rootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .recents, tag: 0)

        let videosCoordinator = VideosCoordinator(viewControllerContext: viewControllerContext)
        videosCoordinator.rootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)

        self.init(
            viewControllerContext: viewControllerContext,
            conferencesRouter: conferencesCoordinator.anyRouter,
            videosRouter: videosCoordinator.anyRouter
        )
    }

    init(viewControllerContext: ViewControllerContext,
         conferencesRouter: AnyRouter<ConferencesRoute>,
         videosRouter: AnyRouter<VideosRoute>) {

        self.viewControllerContext = viewControllerContext
        self.conferencesRouter = conferencesRouter
        self.videosRouter = videosRouter

        super.init(tabs: [conferencesRouter, videosRouter], select: conferencesRouter)
    }

    // MARK: Overrides

    override func prepareTransition(for route: DashboardRoute) -> TabBarTransition {
        switch route {
        case .conferences:
            return .select(conferencesRouter)
        case .videos:
            return .select(videosRouter)
        }
    }

}

enum DashboardRoute: Route {
    case conferences
    case videos
//    case authors
//    case more
}
