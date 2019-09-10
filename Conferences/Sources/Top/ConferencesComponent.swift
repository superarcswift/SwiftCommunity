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

    override func trigger(_ route: ConferencesComponentRoute) -> ComponentPresentable? {
        return componentsRouter?.trigger(route)
    }
}

// MARK: - ConferencesViewBuilder

protocol ConferencesViewBuilder {
    func makeConferencesCollectionViewController(router: AnyRouter<ConferencesRoute>) -> ConferencesCollectionViewController
    func makeConferenceDetailViewController(conferenceMetaData: ConferenceMetaData, router: AnyRouter<ConferencesRoute>) -> ConferenceDetailViewController
}

// MARK: - ConferencesComponentRouter

public protocol ConferencesComponentRouterProtocol: ComponentRouter, ComponentRouterIdentifiable where ComponentRouteType == ConferencesComponentRoute {}

extension ConferencesComponentRouterProtocol where ComponentRouteType == ConferencesComponentRoute {

    public var anyConferencesRouter: AnyComponentRouter<ConferencesComponentRoute> {
        return AnyComponentRouter(self)
    }
}

public enum ConferencesComponentRoute: ComponentRoute {
    case videos(ConferenceMetaData, ConferenceEdition)
    case video(VideoMetaData)
}
