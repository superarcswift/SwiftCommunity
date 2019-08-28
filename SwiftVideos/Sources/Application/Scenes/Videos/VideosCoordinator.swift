//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SwiftVideos_Core
import SwiftVideos_DataModels
import SuperArcCoreUI
import SuperArcCore
import XCoordinator
import RxSwift

class VideosCoordinator: NavigationCoordinator<VideosRoute> {

    // MARK: Properties

    // Private

    private let component: VideosComponent

    // MARK: Initialization

    init(initialRoute: VideosRoute, depedency: VideosDependency, context: ApplicationContext) {
        component = VideosComponent(dependency: depedency, context: context)
        super.init(initialRoute: initialRoute)
    }

    // MARK: Overrides

    override func prepareTransition(for route: VideosRoute) -> NavigationTransition {
        switch route {
        case .videos(let conferenceMetaData, let conferenceEdition):
            let viewController = component.viewBuilder.makeVideosCollectionViewController(conferenceMetaData: conferenceMetaData, conferenceEdition: conferenceEdition, router: anyRouter)
            return .push(viewController)

        case .videoDetail(let videoMetaData, let hasLeftCloseButton):
            let viewController = component.viewBuilder.makeVideoDetailViewController(videoMetaData: videoMetaData, hasLeftCloseButton: hasLeftCloseButton, router: anyRouter)
            return .push(viewController)

        case .close:
            return .dismissToRoot()
        }
    }

}

enum VideosRoute: Route {
    case videos(ConferenceMetaData?, ConferenceEdition?)
    case videoDetail(VideoMetaData, Bool)
    case close
}
