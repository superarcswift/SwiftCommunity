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

public class AuthorsCoordinator: NavigationCoordinator<AuthorsRoute> {

    // MARK: Properties

    // Private

    private let component: AuthorsComponent

    // MARK: Initialization

    public init(initialRoute: AuthorsRoute, dependency: AuthorsDependency, componentsRouter: AnyComponentRouter<AuthorsComponentRoute>, context: ApplicationContextProtocol) {
        component = AuthorsComponent(dependency: dependency, componentsRouter: componentsRouter, context: context)
        super.init(initialRoute: initialRoute)
    }

    // MARK: Overrides

    override public func prepareTransition(for route: AuthorsRoute) -> NavigationTransition {
        switch route {
        case .authors:
            let viewController = component.viewBuilder.makeAuthorsCollectionViewController(router: anyRouter)
            return .push(viewController)

        case .authorDetail(let authorMetaData, let hasLeftCloseButton):
            let viewController = component.viewBuilder.makeAuthorDetailViewController(authorMetaData: authorMetaData, hasLeftCloseButton: hasLeftCloseButton, router: anyRouter)
            return .push(viewController)

        case .videoDetail(let videoMetaData):
            let videosComponentPresentable = component.trigger(.video(videoMetaData)) as! ComponentPresentableWrapper
            return .present(videosComponentPresentable.presentable)

        case .close:
            return .dismissToRoot()
        }
    }

}

public enum AuthorsRoute: Route {
    case authors
    case authorDetail(AuthorMetaData, Bool)
    case videoDetail(VideoMetaData)
    case close
}
