//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import DataModels
import SuperArcCoreUI
import SuperArcCore
import XCoordinator
import RxSwift

public class VideosCoordinator: NavigationCoordinator<VideosRoute> {

    // MARK: Properties

    // Private

    private let component: VideosComponent

    // MARK: Initialization

    public init(initialRoute: VideosRoute, depedency: VideosDependency, context: ApplicationContextProtocol) {
        component = VideosComponent(dependency: depedency, context: context)
        super.init(initialRoute: initialRoute)
    }

    // MARK: Overrides

    override public func prepareTransition(for route: VideosRoute) -> NavigationTransition {
        switch route {
        case .videos(let conferenceMetaData, let conferenceEdition):
            let viewController = component.viewBuilder.makeVideosCollectionViewController(conferenceMetaData: conferenceMetaData, conferenceEdition: conferenceEdition, router: anyRouter)
            return .push(viewController)

        case .videoDetail(let videoMetaData, let hasLeftCloseButton):
            let viewController = component.viewBuilder.makeVideoDetailViewController(videoMetaData: videoMetaData, hasLeftCloseButton: hasLeftCloseButton, router: anyRouter)
            return .push(viewController)

        case .authorDetail(let authorMetaData):
            let authorsCoordinator = component.trigger(.videoListByAuthor(authorMetaData))
            return .present(authorsCoordinator)

        case .close:
            return .dismissToRoot()
        }
    }

}

public enum VideosRoute: Route {
    case videos(ConferenceMetaData?, ConferenceEdition?)
    case videoDetail(VideoMetaData, Bool)
    case authorDetail(AuthorMetaData)
    case close
}
