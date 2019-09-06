//
//  Copyright © 2019 An Tran. All rights reserved.
//

import CoreNavigation
import Core
import DataModels
import SuperArcCoreUI
import SuperArcCore
import XCoordinator
import RxSwift

public class ConferencesCoordinator: NavigationCoordinator<ConferencesRoute> {

    // MARK: Properties

    // Private

    private let component: ConferencesComponent

    // MARK: Initialization

    public init(dependency: ConferencesDependency, context: ApplicationContextProtocol) {
        component = ConferencesComponent(dependency: dependency, context: context)
        super.init(initialRoute: .conferences)
    }

    // MARK: Overrides

    override public func prepareTransition(for route: ConferencesRoute) -> NavigationTransition {
        switch route {
        case .conferences:
            let viewController = component.viewBuilder.makeConferencesCollectionViewController(router: anyRouter)
            return .push(viewController)

        case .conferenceDetail(let conferenceMetaData):
            let viewController = component.viewBuilder.makeConferenceDetailViewController(conferenceMetaData: conferenceMetaData, router: anyRouter)
            return .push(viewController)

        case .conferenceEditionDetail(let conferenceMetaData, let conferenceEdition):
            let videosCoordinator = component.trigger(.videoListByConference(conferenceMetaData, conferenceEdition))
            return .present(videosCoordinator)

        case .video(let videoMetaData):
            let videosCoordinator = component.trigger(.videoDetail(videoMetaData))
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
    case video(VideoMetaData)
    case close
}
