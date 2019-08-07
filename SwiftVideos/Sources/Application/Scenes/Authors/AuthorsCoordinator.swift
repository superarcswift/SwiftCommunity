//
//  Copyright © 2019 An Tran. All rights reserved.
//

import XCoordinator
import SuperArcCoreUI
import SuperArcCore
import RxSwift

class AuthorsCoordinator: NavigationCoordinator<AuthorsRoute> {

    // MARK: Properties

    // Private

    private var context: ApplicationContext

    // MARK: Initialization

    init(context: ApplicationContext) {
        self.context = context
        super.init(initialRoute: .authors)
    }

    // MARK: Overrides

    override func prepareTransition(for route: AuthorsRoute) -> NavigationTransition {
        switch route {
        case .authors:
            let viewController = AuthorsCollectionViewController.instantiate(with: context)
            let viewModel = AuthorsCollectionViewModel(router: anyRouter, engine: context.engine)
            viewController.storedViewModel = viewModel
            return .push(viewController)

        case .authorDetail(let authorMetaData):
            let viewController = AuthorDetailViewController.instantiate(with: context)
            let viewModel = AuthorDetailViewModel(authorMetaData: authorMetaData, router: anyRouter, engine: context.engine)
            viewController.storedViewModel = viewModel
            return .push(viewController)

        case .videoDetail(let videoMetaData):
            let videoCoordinator = VideosCoordinator(initialRoute: .videoDetail(videoMetaData, true), context: context)
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
