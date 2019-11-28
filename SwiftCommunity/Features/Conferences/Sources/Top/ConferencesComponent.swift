//
//  Copyright © 2019 An Tran. All rights reserved.
//

import CoreUX
import Core
import DataModels
import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import XCoordinator

// MARK: - ConferencesComponent

class ConferencesComponent: Component<ConferencesDependency, ConferencesViewBuilder, EmptyInterface, ConferencesComponentRoute>, ConferencesViewBuilder {

    public var unownedViewBuilder: UnownedWrapper<ConferencesComponent> {
        return UnownedWrapper(self)
    }

    // MARK: APIs

    func makeConferencesCollectionViewController(router: UnownedRouter<ConferencesRoute>, builder: UnownedWrapper<ConferencesComponent>?) -> ConferencesCollectionViewController {
        let viewController = ConferencesCollectionViewController.instantiate(with: viewControllerContext)
        viewController.builder = unownedViewBuilder
        let viewModel = ConferencesCollectionViewModel(router: router, dependency: dependency)
        viewController.viewModel = viewModel

        return viewController
    }

    func makeConferenceDetailViewController(conferenceMetaData: ConferenceMetaData, router: UnownedRouter<ConferencesRoute>) -> ConferenceDetailViewController {
        let viewController = ConferenceDetailViewController.instantiate(with: viewControllerContext)
        let viewModel = ConferenceDetailViewModel(conferenceMetaData: conferenceMetaData, router: router, dependency: dependency)
        viewController.viewModel = viewModel

        return viewController
    }

    override func trigger(_ route: ConferencesComponentRoute) -> ComponentPresentable? {
        return router?.trigger(route)
    }
}

// MARK: - ConferencesViewBuilder

protocol ConferencesViewBuilder {
    func makeConferencesCollectionViewController(router: UnownedRouter<ConferencesRoute>, builder: UnownedWrapper<ConferencesComponent>?) -> ConferencesCollectionViewController
    func makeConferenceDetailViewController(conferenceMetaData: ConferenceMetaData, router: UnownedRouter<ConferencesRoute>) -> ConferenceDetailViewController
}

// MARK: - ConferencesComponentRouter

public protocol ConferencesComponentRouterProtocol: ComponentRouter where ComponentRouteType == ConferencesComponentRoute {}

extension ConferencesComponentRouterProtocol where ComponentRouteType == ConferencesComponentRoute {

    public var anyConferencesRouter: AnyComponentRouter<ConferencesComponentRoute> {
        return AnyComponentRouter(self)
    }
}

public enum ConferencesComponentRoute: ComponentRoute {
    case videos(ConferenceMetaData, ConferenceEdition)
    case video(VideoMetaData)
}
