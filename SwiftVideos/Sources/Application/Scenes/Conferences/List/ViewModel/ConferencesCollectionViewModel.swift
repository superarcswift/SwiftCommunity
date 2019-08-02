//
//  Copyright © 2019 An Tran. All rights reserved.
//

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

class ConferencesCollectionViewModel: CoordinatedViewModel<ConferencesRoute>, ConferencesCollectionViewModelOutput, ConferencesCollectionViewModelInput {

    // MARK: Properties

    // Private

    private lazy var showConferenceAction = Action<ConferenceMetaData, Void> { [unowned self] conference in
        self.router.rx.trigger(.conferenceDetail(conference))
    }

    // Public

    lazy var didSelectConferenceTrigger: AnyObserver<ConferenceMetaData> = showConferenceAction.inputs
    var conferences = BehaviorRelay<[ConferenceMetaData]>(value: [])

    var isEmpty = PublishSubject<Bool>()

    // MARK: APIs

    func loadData() {
        conferencesService.fetchList()
            .done { [weak self] conferences in
                self?.conferences.accept(conferences)
            }
            .catch { [weak self] error in
                print(error)
                self?.isEmpty.on(.next(true))
            }
    }

    func bannerImage(for conference: ConferenceMetaData) -> UIImage? {
        guard let bannerImageURL = conferencesService.bannerImageURL(for: conference) else {
            return nil
        }

        guard let bannerImage = UIImage(contentsOfFile: bannerImageURL.path) else {
            return nil
        }

        return bannerImage
    }
}

// MARK: Dependencies

extension ConferencesCollectionViewModel {

    var conferencesService: ConferencesService {
        return engine.serviceRegistry.resolve(type: ConferencesService.self)
    }
}
