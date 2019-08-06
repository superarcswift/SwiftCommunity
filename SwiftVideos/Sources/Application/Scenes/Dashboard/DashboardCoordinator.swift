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
    private let authorsRouter: AnyRouter<AuthorsRoute>
    private let moreRouter: AnyRouter<MoreRoute>

    // MARK: Initialization

    convenience init(viewControllerContext: ViewControllerContext) {
        let conferencesCoordinator = ConferencesCoordinator(viewControllerContext: viewControllerContext)
        conferencesCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Conferences", image: nil, tag: 0)

        let videosCoordinator = VideosCoordinator(initialRoute: .videos(nil, nil), viewControllerContext: viewControllerContext)
        videosCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Videos", image: nil, tag: 1)

        let authorsCoordinator = AuthorsCoordinator(viewControllerContext: viewControllerContext)
        authorsCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Authors", image: nil, tag: 2)

        let moreCoordinator = MoreCoordinator(viewControllerContext: viewControllerContext)
        moreCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "More", image: nil, tag: 3)

        self.init(
            viewControllerContext: viewControllerContext,
            conferencesRouter: conferencesCoordinator.anyRouter,
            videosRouter: videosCoordinator.anyRouter,
            authorsRouter: authorsCoordinator.anyRouter,
            moreRouter: moreCoordinator.anyRouter
        )
    }

    init(viewControllerContext: ViewControllerContext,
         conferencesRouter: AnyRouter<ConferencesRoute>,
         videosRouter: AnyRouter<VideosRoute>,
         authorsRouter: AnyRouter<AuthorsRoute>,
         moreRouter: AnyRouter<MoreRoute>) {

        self.viewControllerContext = viewControllerContext
        self.conferencesRouter = conferencesRouter
        self.videosRouter = videosRouter
        self.authorsRouter = authorsRouter
        self.moreRouter = moreRouter

        super.init(tabs: [conferencesRouter, videosRouter, authorsRouter, moreRouter], select: conferencesRouter)
    }

    // MARK: Overrides

    override func prepareTransition(for route: DashboardRoute) -> TabBarTransition {
        switch route {
        case .conferences:
            return .select(conferencesRouter)
        case .videos:
            return .select(videosRouter)
        case .authors:
            return .select(authorsRouter)
        case .more:
            return .select(moreRouter)
        }
    }

}

enum DashboardRoute: Route {
    case conferences
    case videos
    case authors
    case more
}
