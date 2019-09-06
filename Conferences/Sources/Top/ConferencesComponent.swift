//
//  Copyright © 2019 An Tran. All rights reserved.
//

import CoreNavigation
import CoreUX
import Core
import DataModels
import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import XCoordinator

/// Protocol used to mock for testing purpose.
protocol ConferencesViewBuilder {
    func makeConferencesCollectionViewController(router: AnyRouter<ConferencesRoute>) -> ConferencesCollectionViewController
    func makeConferenceDetailViewController(conferenceMetaData: ConferenceMetaData, router: AnyRouter<ConferencesRoute>) -> ConferenceDetailViewController
}

public protocol ConferencesComponentRoutable {
    func trigger(_ route: NavigationRoute) -> Presentable
}

class ConferencesComponent: Component<ConferencesDependency, ConferencesViewBuilder, EmptyInterface, NavigationRoute>, ConferencesViewBuilder {

    // MARK: APIs

    func makeConferencesCollectionViewController(router: AnyRouter<ConferencesRoute>) -> ConferencesCollectionViewController {
        let viewController = ConferencesCollectionViewController.instantiate(with: context.viewControllerContext)
        let viewModel = ConferencesCollectionViewModel(router: router, dependency: dependency)
        viewController.viewModel = viewModel

        return viewController
    }

    func makeConferenceDetailViewController(conferenceMetaData: ConferenceMetaData, router: AnyRouter<ConferencesRoute>) -> ConferenceDetailViewController {
        let viewController = ConferenceDetailViewController.instantiate(with: context.viewControllerContext)
        let viewModel = ConferenceDetailViewModel(conferenceMetaData: conferenceMetaData, router: router, dependency: dependency)
        viewController.viewModel = viewModel

        return viewController
    }

    override func trigger(_ route: NavigationRoute) -> Presentable {
        return (componentsInteractor as! ConferencesComponentRoutable).trigger(route)
    }

}
