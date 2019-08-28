//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SwiftVideos_Core
import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import XCoordinator
import RxSwift
import UIKit

class DashboardCoordinator: TabBarCoordinator<DashboardRoute> {

    // MARK: Properties

    // Private

    private let component: DashboardComponent

    private let conferencesRouter: AnyRouter<ConferencesRoute>
    private let videosRouter: AnyRouter<VideosRoute>
    private let authorsRouter: AnyRouter<AuthorsRoute>
    private let moreRouter: AnyRouter<MoreRoute>

    // MARK: Initialization

    init(context: ApplicationContext) {

        component = DashboardComponent(dependency: EmptyComponent(), context: context)

        let conferencesCoordinator = ConferencesCoordinator(dependency: component, context: context)
        conferencesCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Conferences", image: nil, tag: 0)
        conferencesRouter = conferencesCoordinator.anyRouter

        let videosCoordinator = VideosCoordinator(initialRoute: .videos(nil, nil), depedency: component, context: context)
        videosCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Videos", image: nil, tag: 1)
        videosRouter = videosCoordinator.anyRouter

        let authorsCoordinator = AuthorsCoordinator(dependency: component, context: context)
        authorsCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Authors", image: nil, tag: 2)
        authorsRouter = authorsCoordinator.anyRouter

        let moreCoordinator = MoreCoordinator(dependency: component, context: context)
        moreCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "More", image: nil, tag: 3)
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
