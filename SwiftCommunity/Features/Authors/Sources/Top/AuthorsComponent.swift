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

    func makeAuthorsCollectionViewController(router: UnownedRouter<AuthorsRoute>) -> AuthorsCollectionViewController {

        let viewController = AuthorsCollectionViewController.instantiate(with: viewControllerContext)
        let viewModel = AuthorsCollectionViewModel(router: router, dependency: dependency)
        viewController.viewModel = viewModel

        return viewController
    }

    func makeAuthorDetailViewController(authorMetaData: AuthorMetaData, hasLeftCloseButton: Bool, router: UnownedRouter<AuthorsRoute>) -> AuthorDetailViewController {
        let viewController = AuthorDetailViewController.instantiate(with: viewControllerContext)
        let viewModel = AuthorDetailViewModel(authorMetaData: authorMetaData, router: router, dependency: dependency)
        viewController.viewModel = viewModel
        viewController.hasLeftCloseButton = hasLeftCloseButton

        return viewController
    }

    override func trigger(_ route: AuthorsComponentRoute) -> ComponentPresentable? {
        return componentsRouter?.trigger(route)
    }
}

// MARK: - AuthorsViewBuilder

protocol AuthorsViewBuilder: ViewBuildable {
    func makeAuthorsCollectionViewController(router: UnownedRouter<AuthorsRoute>) -> AuthorsCollectionViewController
    func makeAuthorDetailViewController(authorMetaData: AuthorMetaData, hasLeftCloseButton: Bool, router: UnownedRouter<AuthorsRoute>) -> AuthorDetailViewController
}

// MARK: AuthorsInterfaceProtocol

public class AuthorsInterface: AuthorsInterfaceProtocol, OnDemandInterface {

    // MARK: Properties

    public weak var dependencyProvider: DependencyProvider!
    public weak var viewControllerContext: ViewControllerContext!

    // MARK: Initialization

    public required init(onDemandWith viewControllerContext: ViewControllerContext, and dependencyProvider: DependencyProvider) {
        self.viewControllerContext = viewControllerContext
        self.dependencyProvider = dependencyProvider
    }

    // MARK: APIs

    public func showAuthor(authorMetaData: AuthorMetaData, dependency: AuthorsDependency, anyAuthorsRouter: AnyComponentRouter<AuthorsComponentRoute>) -> Presentable {
        return AuthorsCoordinator(
            initialRoute: .authorDetail(authorMetaData, true),
            dependency: dependency,
            componentsRouter: anyAuthorsRouter,
            viewControllerContext: viewControllerContext,
            context: dependencyProvider.context)
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
