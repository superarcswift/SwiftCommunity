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

/// Protocol used to mock for testing purpose.
protocol AuthorsViewBuilder: ViewBuildable {
    func makeAuthorsCollectionViewController(router: AnyRouter<AuthorsRoute>) -> AuthorsCollectionViewController
    func makeAuthorDetailViewController(authorMetaData: AuthorMetaData, router: AnyRouter<AuthorsRoute>) -> AuthorDetailViewController
}

class AuthorsComponent: Component<AuthorsDependency, AuthorsViewBuilder, AuthorsNavigationDelegate, EmptyInterface>, AuthorsViewBuilder {

    // MARK: Initialization

    override init(dependency: DependencyType, context: ApplicationContextProtocol) {
        super.init(dependency: dependency, context: context)
        navigationDelegate = context.viewControllerContext.resolve(type: NavigationDelegateManagerProtocol.self) as? AuthorsNavigationDelegate
    }

    // MARK: APIs

    func makeAuthorsCollectionViewController(router: AnyRouter<AuthorsRoute>) -> AuthorsCollectionViewController {

        let viewController = AuthorsCollectionViewController.instantiate(with: context.viewControllerContext)
        let viewModel = AuthorsCollectionViewModel(router: router, dependency: dependency)
        viewController.viewModel = viewModel

        return viewController
    }

    func makeAuthorDetailViewController(authorMetaData: AuthorMetaData, router: AnyRouter<AuthorsRoute>) -> AuthorDetailViewController {
        let viewController = AuthorDetailViewController.instantiate(with: context.viewControllerContext)
        let viewModel = AuthorDetailViewModel(authorMetaData: authorMetaData, router: router, dependency: dependency)
        viewController.viewModel = viewModel

        return viewController
    }
}

// MARK: Children's dependencies

extension AuthorsComponent: HasVideosService {
    var videosService: VideosServiceProtocol {
        return context.engine.serviceRegistry.resolve(type: VideosServiceProtocol.self)
    }
}

extension AuthorsComponent: HasAuthorsService {
    var authorsService: AuthorsServiceProtocol {
        return context.engine.serviceRegistry.resolve(type: AuthorsServiceProtocol.self)
    }
}
