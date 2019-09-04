//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import DataModels
import SuperArcCoreUI
import SuperArcCore
import XCoordinator
import RxSwift

public class AuthorsCoordinator: NavigationCoordinator<AuthorsRoute> {

    // MARK: Properties

    // Private

    private let component: AuthorsComponent

    // MARK: Initialization

    public init(dependency: AuthorsDependency, context: ApplicationContextProtocol) {
        component = AuthorsComponent(dependency: dependency, context: context)
        super.init(initialRoute: .authors)
    }

    // MARK: Overrides

    override public func prepareTransition(for route: AuthorsRoute) -> NavigationTransition {
        switch route {
        case .authors:
            let viewController = component.viewBuilder.makeAuthorsCollectionViewController(router: anyRouter)
            return .push(viewController)

        case .authorDetail(let authorMetaData):
            let viewController = component.viewBuilder.makeAuthorDetailViewController(authorMetaData: authorMetaData, router: anyRouter)
            return .push(viewController)

        case .videoDetail(let videoMetaData):
            //let videoCoordinator = VideosCoordinator(initialRoute: .videoDetail(videoMetaData, true), depedency: component, context: component.context)
            let videosCoordinator = component.navigationDelegate.showVideo(videoMetaData: videoMetaData, dependency: component, context: component.context)
            return .present(videosCoordinator)

        case .close:
            return .dismissToRoot()
        }
    }

}

public enum AuthorsRoute: Route {
    case authors
    case authorDetail(AuthorMetaData)
    case videoDetail(VideoMetaData)
    case close
}
