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

    // MARK: Initialization

    public init(dependency: ConferencesDependency, componentsRouter: AnyComponentRouter<ConferencesComponentRoute>, context: ApplicationContextProtocol) {
        component = ConferencesComponent(dependency: dependency, componentsRouter: componentsRouter, context: context)
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
            let videosCoordinator = component.trigger(.videos(conferenceMetaData, conferenceEdition))
            return .present(videosCoordinator)

        case .video(let videoMetaData):
            let videosCoordinator = component.trigger(.video(videoMetaData))
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
