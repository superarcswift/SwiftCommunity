//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import DataModels
import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import XCoordinator

// MARK: - AuthorsComponent

class AuthorsComponent: Component<AuthorsDependency, AuthorsViewBuilder, EmptyInterface, AuthorsComponentRoute>, AuthorsViewBuilder {

    // MARK: APIs

    func makeAuthorsCollectionViewController(router: AnyRouter<AuthorsRoute>) -> AuthorsCollectionViewController {

        let viewController = AuthorsCollectionViewController.instantiate(with: context.viewControllerContext)
        let viewModel = AuthorsCollectionViewModel(router: router, dependency: dependency)
        viewController.viewModel = viewModel

        return viewController
    }

    func makeAuthorDetailViewController(authorMetaData: AuthorMetaData, hasLeftCloseButton: Bool, router: AnyRouter<AuthorsRoute>) -> AuthorDetailViewController {
        let viewController = AuthorDetailViewController.instantiate(with: context.viewControllerContext)
        let viewModel = AuthorDetailViewModel(authorMetaData: authorMetaData, router: router, dependency: dependency)
        viewController.viewModel = viewModel
        viewController.hasLeftCloseButton = hasLeftCloseButton

        return viewController
    }

    override func trigger(_ route: AuthorsComponentRoute) -> ComponentPresentable {
        return componentsRouter.trigger(route)
    }
}

// MARK: - AuthorsViewBuilder

protocol AuthorsViewBuilder: ViewBuildable {
    func makeAuthorsCollectionViewController(router: AnyRouter<AuthorsRoute>) -> AuthorsCollectionViewController
    func makeAuthorDetailViewController(authorMetaData: AuthorMetaData, hasLeftCloseButton: Bool, router: AnyRouter<AuthorsRoute>) -> AuthorDetailViewController
}

// MARK: AuthorsInterfaceProtocol

public class AuthorsInterface: AuthorsInterfaceProtocol {

    public init() {}

    public func showAuthor(authorMetaData: AuthorMetaData, dependency: AuthorsDependency, anyAuthorsRouter:AnyComponentRouter<AuthorsComponentRoute>, context: ApplicationContextProtocol) -> Presentable {
        return AuthorsCoordinator(initialRoute: .authorDetail(authorMetaData, true), dependency: dependency, componentsRouter: anyAuthorsRouter, context: context)
    }
}

// MARK: - AuthorsComponentRouter

public protocol AuthorsComponentRouterProtocol: ComponentRouter, ComponentRouterIdentifiable where ComponentRouteType == AuthorsComponentRoute {}

extension AuthorsComponentRouterProtocol where ComponentRouteType == AuthorsComponentRoute {

    public var anyAuthorsRouter: AnyComponentRouter<AuthorsComponentRoute> {
        return AnyComponentRouter(self)
    }
}

public enum AuthorsComponentRoute: ComponentRoute {
    case video(VideoMetaData)
}
