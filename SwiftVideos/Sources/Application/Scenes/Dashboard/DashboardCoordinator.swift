//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Conferences
import Videos
import Authors
import CoreUX
import Core
import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import XCoordinator
import RxSwift
import UIKit

typealias DashboardNavigationDelegate = ConferencesNavigationDelegate

class DashboardCoordinator: TabBarCoordinator<DashboardRoute> {

    // MARK: Properties

    // Private

    private let component: DashboardComponent

    private let conferencesRouter: AnyRouter<ConferencesRoute>
    private let videosRouter: AnyRouter<VideosRoute>
    private let authorsRouter: AnyRouter<AuthorsRoute>
    private let moreRouter: AnyRouter<MoreRoute>

    // MARK: Initialization

    init(context: ApplicationContextProtocol) {

        component = DashboardComponent(dependency: EmptyComponent(), context: context)

        let conferencesCoordinator = ConferencesCoordinator(dependency: component, context: context)
        conferencesCoordinator.rootViewController.tabBarItem = UITabBarItem(titleKey: "conferences", image: UIImage(named: "conferences"), tag: 0)
        conferencesRouter = conferencesCoordinator.anyRouter

        let videosCoordinator = VideosCoordinator(initialRoute: .videos(nil, nil), depedency: component, context: context)
        videosCoordinator.rootViewController.tabBarItem = UITabBarItem(titleKey: "videos", image: UIImage(named: "videos"), tag: 1)
        videosRouter = videosCoordinator.anyRouter

        let authorsCoordinator = AuthorsCoordinator(dependency: component, context: context)
        authorsCoordinator.rootViewController.tabBarItem = UITabBarItem(titleKey: "authors", image: UIImage(named: "authors"), tag: 2)
        authorsRouter = authorsCoordinator.anyRouter

        let moreCoordinator = MoreCoordinator(dependency: component, context: context)
        moreCoordinator.rootViewController.tabBarItem = UITabBarItem(titleKey: "more", image: UIImage(named: "more"), tag: 3)
        moreRouter = moreCoordinator.anyRouter

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
