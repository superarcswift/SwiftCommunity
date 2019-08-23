//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import XCoordinator

/// Protocol defining all dependencies required by this component..
typealias ConferencesDependency = HasConferencesService & HasVideosService & HasAuthorsService

/// Protocol used to mock for testing purpose.
protocol ConferencesBuilder {
    func makeConferencesCollectionViewController(router: AnyRouter<ConferencesRoute>) -> ConferencesCollectionViewController
    func makeConferenceDetailViewController(conferenceMetaData: ConferenceMetaData, router: AnyRouter<ConferencesRoute>) -> ConferenceDetailViewController
}

class ConferencesComponent: Component<ConferencesDependency>, ConferencesBuilder {

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
}

extension ConferencesComponent : HasVideosService {
    var videosService: VideosService {
        return context.engine.serviceRegistry.resolve(type: VideosService.self)
    }
}

extension ConferencesComponent : HasAuthorsService {
    var authorsService: AuthorsService {
        return context.engine.serviceRegistry.resolve(type: AuthorsService.self)
    }
}
