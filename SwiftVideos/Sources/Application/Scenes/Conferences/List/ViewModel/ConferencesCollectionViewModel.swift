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
    var didSelectConferenceTrigger: AnyObserver<Conference> { get }
}

protocol ConferencesCollectionViewModelOutput {
    var conferences: BehaviorRelay<[Conference]> { get set }
}

class ConferencesCollectionViewModel: CoordinatedViewModel<ConferencesRoute>, ConferencesCollectionViewModelOutput, ConferencesCollectionViewModelInput {

    // MARK: Properties

    // Private

    private lazy var showConferenceAction = Action<Conference, Void> { [unowned self] conference in
        self.router.rx.trigger(.conferenceDetail(conference))
    }

    // Public

    lazy var didSelectConferenceTrigger: AnyObserver<Conference> = showConferenceAction.inputs
    var conferences = BehaviorRelay<[Conference]>(value: [])

    // MARK: APIs

    func loadData() {
        conferencesService.fetch()
            .done { [weak self] conferences in
                self?.conferences.accept(conferences)
            }
            .catch { error in
                print(error)
            }
    }
}

// MARK: Dependencies

extension ConferencesCollectionViewModel {

    var conferencesService: ConferencesService {
        return engine.serviceRegistry.resolve(type: ConferencesService.self)
    }
}
