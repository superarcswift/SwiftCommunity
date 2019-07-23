//
//  Copyright © 2019 An Tran. All rights reserved.
//

import XCoordinator
import SuperArcCoreUI
import SuperArcCore
import RxSwift

class ConferencesCoordinator: NavigationCoordinator<ConferencesRoute> {

    // MARK: Properties

    // Private

    // MARK: Initialization

    init() {
        super.init(initialRoute: .conferences)
    }

    // MARK: Overrides

    override func prepareTransition(for route: ConferencesRoute) -> NavigationTransition {
        switch route {
        case .conferences:
            let viewController = ConferencesCollectionViewController.instantiate()
            return .push(viewController)

        case .conferenceDetail(let conference):
            let viewController = ConferencesDetailViewController.instantiate()
            let viewModel = ConferencesDetailViewModel(conference: conference, router: anyRouter, engine: viewController.context.engine)
            viewController.storedViewModel = viewModel
            return .push(viewController)

        case .close:
            return .dismissToRoot()
        }
    }

}

enum ConferencesRoute: Route {
    case conferences
    case conferenceDetail(Conference)
    case close
}
