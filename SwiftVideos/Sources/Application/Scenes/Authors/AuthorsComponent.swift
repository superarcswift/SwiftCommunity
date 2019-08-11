//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import XCoordinator

/// Protocol defining all dependencies required by this component..
typealias AuthorsDependency = Dependency & HasAuthorsService

/// Protocol used to mock for testing purpose.
protocol AuthorsBuilder {
    func makeAuthorsCollectionViewController(router: AnyRouter<AuthorsRoute>) -> AuthorsCollectionViewController
    func makeAuthorDetailViewController(authorMetaData: AuthorMetaData, router: AnyRouter<AuthorsRoute>) -> AuthorDetailViewController
}

class AuthorsComponent: Component<AuthorsDependency>, AuthorsBuilder {

    // MARK: APIs

    func makeAuthorsCollectionViewController(router: AnyRouter<AuthorsRoute>) -> AuthorsCollectionViewController {

        let viewController = AuthorsCollectionViewController.instantiate(with: context)
        viewController.setApplicationContext(context)
        let viewModel = AuthorsCollectionViewModel(router: router, engine: context.engine)
        viewController.viewModel = viewModel

        return viewController
    }

    func makeAuthorDetailViewController(authorMetaData: AuthorMetaData, router: AnyRouter<AuthorsRoute>) -> AuthorDetailViewController {
        let viewController = AuthorDetailViewController.instantiate(with: context)
        let viewModel = AuthorDetailViewModel(authorMetaData: authorMetaData, router: router, dependency: dependency, engine: context.engine)
        viewController.viewModel = viewModel

        return viewController
    }
}

extension AuthorsComponent: HasVideosService {
    var videosService: VideosService {
        return context.engine.serviceRegistry.resolve(type: VideosService.self)
    }
}
