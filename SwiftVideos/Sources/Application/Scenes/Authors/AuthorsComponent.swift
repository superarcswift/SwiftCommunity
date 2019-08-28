//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SwiftVideos_Core
import SwiftVideos_DataModels
import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import XCoordinator

/// Protocol defining all dependencies required by this component..
typealias AuthorsDependency = HasAuthorsService & HasVideosService

/// Protocol used to mock for testing purpose.
protocol AuthorsViewBuilder: ViewBuildable {
    func makeAuthorsCollectionViewController(router: AnyRouter<AuthorsRoute>) -> AuthorsCollectionViewController
    func makeAuthorDetailViewController(authorMetaData: AuthorMetaData, router: AnyRouter<AuthorsRoute>) -> AuthorDetailViewController
}

class AuthorsComponent: Component<AuthorsDependency, AuthorsViewBuilder>, AuthorsViewBuilder {

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
    var videosService: VideosService {
        return context.engine.serviceRegistry.resolve(type: VideosService.self)
    }
}

extension AuthorsComponent: HasAuthorsService {
    var authorsService: AuthorsService {
        return context.engine.serviceRegistry.resolve(type: AuthorsService.self)
    }
}
