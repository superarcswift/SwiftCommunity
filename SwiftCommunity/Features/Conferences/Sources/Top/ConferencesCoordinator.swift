//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import DataModels
import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import XCoordinator
import RxSwift

public class ConferencesCoordinator: NavigationCoordinator<ConferencesRoute> {

    // MARK: Properties

    // Private

    private let component: ConferencesComponent

    var conferenceTransition: ConferenceTransition?

    // MARK: Initialization

    public init(navigator: Navigator,
                dependency: ConferencesDependency,
                router: AnyComponentRouter<ConferencesComponentRoute>,
                viewControllerContext: ViewControllerContext,
                dependencyProvider: DependencyProvider) {

        component = ConferencesComponent(dependency: dependency,
                                         router: router,
                                         viewControllerContext: viewControllerContext,
                                         dependencyProvider: dependencyProvider)
        super.init(initialRoute: .conferences)
    }

    // MARK: Overrides

    override public func prepareTransition(for route: ConferencesRoute) -> NavigationTransition {
        switch route {
        case .conferences:
            let viewController = component.viewBuilder.makeConferencesCollectionViewController(router: unownedRouter, builder: component.unownedViewBuilder)
            return .push(viewController)

        case .conferenceDetail(let conferenceMetaData):
            let viewController = component.viewBuilder.makeConferenceDetailViewController(conferenceMetaData: conferenceMetaData, router: unownedRouter)
            return .push(viewController)

        case .video(let videoMetaData):
            let videosComponentPresentable = component.trigger(.video(videoMetaData)) as! ComponentPresentableWrapper
            return .present(videosComponentPresentable.presentable)

        case .close:
            return .dismissToRoot()
        }
    }

}

public enum ConferencesRoute: Route {
    case conferences
    case conferenceDetail(ConferenceMetaData)
    case video(VideoMetaData)
    case close
}
