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

/// Protocol used to mock for testing purpose.
public protocol ConferencesViewBuilder {
    func makeConferencesCollectionViewController(router: AnyRouter<ConferencesRoute>) -> ConferencesCollectionViewController
    func makeConferenceDetailViewController(conferenceMetaData: ConferenceMetaData, router: AnyRouter<ConferencesRoute>) -> ConferenceDetailViewController
}

public class ConferencesComponent: Component<ConferencesDependency, ConferencesViewBuilder, ConferencesNavigationDelegate>, ConferencesViewBuilder {

    // MARK: Initialization

    public override init(dependency: DependencyType, context: ApplicationContext) {
        super.init(dependency: dependency, context: context)
        navigationDelegate = context.viewControllerContext.resolve(type: NavigationDelegateManager.self) as? ConferencesNavigationDelegate
    }

    // MARK: APIs

    public func makeConferencesCollectionViewController(router: AnyRouter<ConferencesRoute>) -> ConferencesCollectionViewController {
        let viewController = ConferencesCollectionViewController.instantiate(with: context.viewControllerContext)
        let viewModel = ConferencesCollectionViewModel(router: router, dependency: dependency)
        viewController.viewModel = viewModel

        return viewController
    }

    public func makeConferenceDetailViewController(conferenceMetaData: ConferenceMetaData, router: AnyRouter<ConferencesRoute>) -> ConferenceDetailViewController {
        let viewController = ConferenceDetailViewController.instantiate(with: context.viewControllerContext)
        let viewModel = ConferenceDetailViewModel(conferenceMetaData: conferenceMetaData, router: router, dependency: dependency)
        viewController.viewModel = viewModel

        return viewController
    }

}

// MARK: Children's dependencies

extension ConferencesComponent: HasVideosService {
    public var videosService: VideosServiceProtocol {
        return context.engine.serviceRegistry.resolve(type: VideosServiceProtocol.self)
    }
}

extension ConferencesComponent: HasAuthorsService {
    public var authorsService: AuthorsServiceProtocol {
        return context.engine.serviceRegistry.resolve(type: AuthorsServiceProtocol.self)
    }
}
