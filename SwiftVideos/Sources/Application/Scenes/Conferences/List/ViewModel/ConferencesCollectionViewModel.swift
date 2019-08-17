//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcNotificationBanner
import SuperArcStateView
import SuperArcCoreUI
import SuperArcCore
import XCoordinator
import Action
import RxSwift
import RxCocoa

protocol ConferencesCollectionViewModelInput {

    /// Triggered when users select a conference.
    var didSelectConferenceTrigger: AnyObserver<ConferenceMetaData> { get }
}

protocol ConferencesCollectionViewModelOutput {

    /// Emits an array of the ConferenceMetaData that should be displaed.
    var conferences: BehaviorRelay<[ConferenceMetaData]> { get set }
}

protocol ConferencesCollectionViewModelApi {

    func loadData()

    func bannerImage(for conference: ConferenceMetaData) -> UIImage?
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

class ConferencesCollectionViewModel: CoordinatedDIViewModel<ConferencesRoute, ConferencesDependency>, ConferencesCollectionViewModelType, ConferencesCollectionViewModelInput, ConferencesCollectionViewModelOutput, ConferencesCollectionViewModelApi {


    // MARK: Properties

    // Private

    private lazy var showConferenceAction = Action<ConferenceMetaData, Void> { [unowned self] conference in
        self.router.rx.trigger(.conferenceDetail(conference))
    }

    // Public

    lazy var didSelectConferenceTrigger: AnyObserver<ConferenceMetaData> = showConferenceAction.inputs
    var conferences = BehaviorRelay<[ConferenceMetaData]>(value: [])

    var toggleEmptyState = PublishSubject<StandardStateViewContext?>()
    var notification = PublishSubject<SuperArcNotificationBanner.Notification?>()

    // MARK: APIs

    func loadData() {
        dependency.conferencesService.fetchList()
            .done { [weak self] conferences in
                self?.conferences.accept(conferences)
            }
            .catch { [weak self] error in
                self?.toggleEmptyState.on(.next(StandardStateViewContext(headline: error.localizedDescription)))
            }
    }

    func bannerImage(for conference: ConferenceMetaData) -> UIImage? {
        guard let bannerImageURL = dependency.conferencesService.bannerImageURL(for: conference) else {
            return nil
        }

        guard let bannerImage = UIImage(contentsOfFile: bannerImageURL.path) else {
            return nil
        }

        return bannerImage
    }
}
