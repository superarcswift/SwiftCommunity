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

class DashboardCoordinator: TabBarCoordinator<DashboardRoute> {

    // MARK: Properties

    // Private

    private let component: DashboardComponent

    private let conferencesRouter: StrongRouter<ConferencesRoute>
    private let videosRouter: StrongRouter<VideosRoute>
    private let authorsRouter: StrongRouter<AuthorsRoute>
    private let moreRouter: StrongRouter<MoreRoute>

    // MARK: Initialization

    init(viewControllerContext: ViewControllerContext, dependencyProvider: DependencyProvider) {

        component = DashboardComponent(dependency: EmptyComponent(), viewControllerContext: viewControllerContext, dependencyProvider: dependencyProvider)
        let appComponentsRouter = viewControllerContext.resolve(type: ComponentsRouter.self)

        let conferencesComponentRouter = appComponentsRouter.routerRegistry.resolve(type: ConferencesComponentRouter.self)
        let conferencesCoordinator = ConferencesCoordinator(dependency: component, componentsRouter: conferencesComponentRouter.anyConferencesRouter, viewControllerContext: viewControllerContext, dependencyProvider: dependencyProvider)
        conferencesCoordinator.rootViewController.tabBarItem = UITabBarItem(titleKey: "conferences", image: UIImage(named: "conferences"), tag: 0)
        conferencesRouter = conferencesCoordinator.strongRouter

        let videosComponentRouter = appComponentsRouter.routerRegistry.resolve(type: VideosComponentRouter.self)
        let videosCoordinator = VideosCoordinator(initialRoute: .videos(nil, nil), depedency: component, componentsRouter: videosComponentRouter.anyVideosRouter, viewControllerContext: viewControllerContext, dependencyProvider: dependencyProvider)
        videosCoordinator.rootViewController.tabBarItem = UITabBarItem(titleKey: "videos", image: UIImage(named: "videos"), tag: 1)
        videosRouter = videosCoordinator.strongRouter

        let authorsComponentRouter = appComponentsRouter.routerRegistry.resolve(type: AuthorsComponentRouter.self)
        let authorsCoordinator = AuthorsCoordinator(initialRoute: .authors, dependency: component, componentsRouter: authorsComponentRouter.anyAuthorsRouter, viewControllerContext: viewControllerContext, dependencyProvider: dependencyProvider)
        authorsCoordinator.rootViewController.tabBarItem = UITabBarItem(titleKey: "authors", image: UIImage(named: "authors"), tag: 2)
        authorsRouter = authorsCoordinator.strongRouter

        let moreCoordinator = MoreCoordinator(dependency: component, viewControllerContext: viewControllerContext, dependencyProvider: dependencyProvider)
        moreCoordinator.rootViewController.tabBarItem = UITabBarItem(titleKey: "more", image: UIImage(named: "more"), tag: 3)
        moreRouter = moreCoordinator.strongRouter

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
