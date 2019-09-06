//
//  Copyright © 2019 An Tran. All rights reserved.
//

import CoreNavigation
import Core
import DataModels
import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import XCoordinator

/// Protocol used to mock for testing purpose.
protocol AuthorsViewBuilder: ViewBuildable {
    func makeAuthorsCollectionViewController(router: AnyRouter<AuthorsRoute>) -> AuthorsCollectionViewController
    func makeAuthorDetailViewController(authorMetaData: AuthorMetaData, hasLeftCloseButton: Bool, router: AnyRouter<AuthorsRoute>) -> AuthorDetailViewController
}

public protocol AuthorsComponentRoutable {
    func trigger(_ route: NavigationRoute) -> Presentable
}

class AuthorsComponent: Component<AuthorsDependency, AuthorsViewBuilder, EmptyInterface, NavigationRoute>, AuthorsViewBuilder {

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

    override func trigger(_ route: NavigationRoute) -> Presentable {
        return (componentsInteractor as! AuthorsComponentRoutable).trigger(route)
    }
}

// MARK: AuthorsInterfaceProtocol

public class AuthorsInterface: AuthorsInterfaceProtocol {

    public init() {}

    public func showAuthor(authorMetaData: AuthorMetaData, dependency: AuthorsDependency, context: ApplicationContextProtocol) -> Presentable {
        return AuthorsCoordinator(initialRoute: .authorDetail(authorMetaData, true), dependency: dependency, context: context)
    }
}
