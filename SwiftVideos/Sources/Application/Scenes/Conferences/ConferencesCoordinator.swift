//
//  Copyright © 2019 An Tran. All rights reserved.
//

import XCoordinator
import SuperArcCoreUI
import SuperArcCore
import RxSwift

class ConferencesCoordinator: NavigationCoordinator<ConferencesRoute> {

    // MARK: Properties

    // Private

    private let component: ConferencesComponent

    // MARK: Initialization

    init(dependency: ConferencesDependency, context: ApplicationContext) {
        component = ConferencesComponent(dependency: dependency, context: context)
        super.init(initialRoute: .conferences)
    }

    // MARK: Overrides

    override func prepareTransition(for route: ConferencesRoute) -> NavigationTransition {
        switch route {
        case .conferences:
            let viewController = component.makeConferencesCollectionViewController(router: anyRouter)
            return .push(viewController)

        case .conferenceDetail(let conferenceMetaData):
            let viewController = component.makeConferenceDetailViewController(conferenceMetaData: conferenceMetaData, router: anyRouter)
            return .push(viewController)

        case .conferenceEditionDetail(let conferenceMetaData, let conferenceEdition):
            let videosCoordinator = VideosCoordinator(initialRoute: .videos(conferenceMetaData, conferenceEdition), depedency: component, context: component.context)
            return .present(videosCoordinator)

        case .close:
            return .dismissToRoot()
        }
    }

}

public enum ConferencesRoute: Route {
    case conferences
    case conferenceDetail(ConferenceMetaData)
    case conferenceEditionDetail(ConferenceMetaData, ConferenceEdition)
    case close
}
