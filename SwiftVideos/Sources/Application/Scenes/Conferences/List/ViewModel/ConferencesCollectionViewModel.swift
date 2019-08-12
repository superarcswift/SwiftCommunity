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
    var didSelectConferenceTrigger: AnyObserver<ConferenceMetaData> { get }
}

protocol ConferencesCollectionViewModelOutput {
    var conferences: BehaviorRelay<[ConferenceMetaData]> { get set }
}

class ConferencesCollectionViewModel: CoordinatedDIViewModel<ConferencesRoute, ConferencesDependency>, ConferencesCollectionViewModelOutput, ConferencesCollectionViewModelInput {

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
                print(error)
                self?.toggleEmptyState.on(.next(StandardStateViewContext(headline: error.localizedDescription)))
            }
    }

    public func bannerImage(for conference: ConferenceMetaData) -> UIImage? {
        guard let bannerImageURL = dependency.conferencesService.bannerImageURL(for: conference) else {
            return nil
        }

        guard let bannerImage = UIImage(contentsOfFile: bannerImageURL.path) else {
            return nil
        }

        return bannerImage
    }
}
