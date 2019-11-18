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

public class VideosCoordinator: NavigationCoordinator<VideosRoute> {

    // MARK: Properties

    // Private

    private let component: VideosComponent

    // MARK: Initialization

    public init(initialRoute: VideosRoute, depedency: VideosDependency, componentsRouter: AnyComponentRouter<VideosComponentRoute>, viewControllerContext: ViewControllerContext, context: ApplicationContextProtocol) {
        component = VideosComponent(dependency: depedency, componentsRouter: componentsRouter, viewControllerContext: viewControllerContext, context: context)
        super.init(initialRoute: initialRoute)
    }

    // MARK: APIs

    public static func register(to context: ApplicationContextProtocol) {
        VideosComponent.register(to: context)
    }

    override public func prepareTransition(for route: VideosRoute) -> NavigationTransition {
        switch route {
        case .videos(let conferenceMetaData, let conferenceEdition):
            let viewController = component.viewBuilder.makeVideosCollectionViewController(conferenceMetaData: conferenceMetaData, conferenceEdition: conferenceEdition, router: unownedRouter)
            return .push(viewController)

        case .videoDetail(let videoMetaData, let hasLeftCloseButton):
            let viewController = component.viewBuilder.makeVideoDetailViewController(videoMetaData: videoMetaData, hasLeftCloseButton: hasLeftCloseButton, router: unownedRouter)
            return .push(viewController)

        case .authorDetail(let authorMetaData):
            let authorsComponentPresentable = component.trigger(.author(authorMetaData)) as! ComponentPresentableWrapper
            return .present(authorsComponentPresentable.presentable)

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
