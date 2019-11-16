//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import SuperArcNotificationBanner
import SuperArcStateView
import SuperArcCoreUI
import SuperArcCore
import XCoordinator
import XCoordinatorRx
import Action
import RxCocoa
import RxSwift

protocol ConferencesCollectionViewModelInput {

    /// Triggered when users select a conference.
    var didSelectConferenceTrigger: AnyObserver<ConferenceViewModel> { get }
}

protocol ConferencesCollectionViewModelOutput {

    /// Emits an array of the ConferenceViewModel that should be displaed.
    var conferences: BehaviorRelay<[ConferenceViewModel]> { get set }
}

protocol ConferencesCollectionViewModelApi {

    func loadData()
}

protocol ConferencesCollectionViewModelType {
    var inputs: ConferencesCollectionViewModelInput { get }
    var outputs: ConferencesCollectionViewModelOutput { get }
    var apis: ConferencesCollectionViewModelApi { get }
}

extension ConferencesCollectionViewModelType where Self: ConferencesCollectionViewModelInput & ConferencesCollectionViewModelOutput & ConferencesCollectionViewModelApi {

    var inputs: ConferencesCollectionViewModelInput {
        return self
    }

    var outputs: ConferencesCollectionViewModelOutput {
        return self
    }

    var apis: ConferencesCollectionViewModelApi {
        return self
    }
}

public class ConferencesCollectionViewModel: CoordinatedDIViewModel<ConferencesRoute, ConferencesDependency>, ConferencesCollectionViewModelType, ConferencesCollectionViewModelInput, ConferencesCollectionViewModelOutput, ConferencesCollectionViewModelApi {

    // MARK: Properties

    // Private

    private lazy var showConferenceAction = Action<ConferenceViewModel, Void> { [unowned self] conference in
        self.router.rx.trigger(.conferenceDetail(conference.conferenceMetaData))
    }

    // Public

    lazy var didSelectConferenceTrigger: AnyObserver<ConferenceViewModel> = showConferenceAction.inputs
    var conferences = BehaviorRelay<[ConferenceViewModel]>(value: [])

    var toggleEmptyState = PublishSubject<StandardStateViewContext?>()
    var notification = PublishSubject<SuperArcNotificationBanner.Notification?>()

    // MARK: APIs

    func loadData() {
        dependency.conferencesService.fetchList()
            .mapValues {
                ConferenceViewModel(conferenceMetaData: $0, conferencesService: self.dependency.conferencesService)
            }
            .done { [weak self] conferences in
                self?.conferences.accept(conferences)
            }
            .catch { [weak self] error in
                self?.toggleEmptyState.on(.next(StandardStateViewContext(headline: error.localizedDescription)))
            }
    }
}
