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

    private var context: ApplicationContext

    // MARK: Initialization

    init(context: ApplicationContext) {
        self.context = context
        super.init(initialRoute: .conferences)
    }

    // MARK: Overrides

    override func prepareTransition(for route: ConferencesRoute) -> NavigationTransition {
        switch route {
        case .conferences:
            let viewController = ConferencesCollectionViewController.instantiate(with: context)
            let viewModel = ConferencesCollectionViewModel(router: anyRouter, engine: context.engine)
            viewController.storedViewModel = viewModel
            return .push(viewController)

        case .conferenceDetail(let conferenceMetaData):
            let viewController = ConferenceDetailViewController.instantiate(with: context)
            let viewModel = ConferenceDetailViewModel(conferenceMetaData: conferenceMetaData, router: anyRouter, engine: context.engine)
            viewController.storedViewModel = viewModel
            return .push(viewController)

        case .conferenceEditionDetail(let conferenceMetaData, let conferenceEdition):
            let videosCoordinator = VideosCoordinator(initialRoute: .videos(conferenceMetaData, conferenceEdition), context: context)
            return .present(videosCoordinator)

        case .close:
            return .dismissToRoot()
        }
    }

}

public enum ConferencesRoute: Route {
    case conferences
    case conferenceDetail(ConferenceMetaData)
    case conferenceEditionDetail(ConferenceMetaData, ConferenceEdition)
    case close
}
