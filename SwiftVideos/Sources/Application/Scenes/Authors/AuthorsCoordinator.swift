//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SwiftVideos_DataModels
import SuperArcCoreUI
import SuperArcCore
import XCoordinator
import RxSwift

class AuthorsCoordinator: NavigationCoordinator<AuthorsRoute> {

    // MARK: Properties

    // Private

    private let component: AuthorsComponent

    // MARK: Initialization

    init(dependency: AuthorsDependency, context: ApplicationContext) {
        component = AuthorsComponent(dependency: dependency, context: context)
        super.init(initialRoute: .authors)
    }

    // MARK: Overrides

    override func prepareTransition(for route: AuthorsRoute) -> NavigationTransition {
        switch route {
        case .authors:
            let viewController = component.makeAuthorsCollectionViewController(router: anyRouter)
            return .push(viewController)

        case .authorDetail(let authorMetaData):
            let viewController = component.makeAuthorDetailViewController(authorMetaData: authorMetaData, router: anyRouter)
            return .push(viewController)

        case .videoDetail(let videoMetaData):
            let videoCoordinator = VideosCoordinator(initialRoute: .videoDetail(videoMetaData, true), depedency: component, context: component.context)
            return .present(videoCoordinator)

        case .close:
            return .dismissToRoot()
        }
    }

}

enum AuthorsRoute: Route {
    case authors
    case authorDetail(AuthorMetaData)
    case videoDetail(VideoMetaData)
    case close
}
