//
//  Copyright © 2019 An Tran. All rights reserved.
//

import XCoordinator
import SuperArcCoreUI
import SuperArcCore
import Action
import RxSwift
import RxCocoa

protocol ConferenceDetailViewModelInput {
    var conferenceMetaData: ConferenceMetaData { get }
    var didSelectConferenceEditionTrigger: AnyObserver<ConferenceEdition> { get }
}

protocol ConferenceDetailViewModelOutput {
    var conferenceEditions: BehaviorRelay<[ConferenceEdition]> { get set }
}

public class ConferenceDetailViewModel: ViewModel, ConferenceDetailViewModelInput, ConferenceDetailViewModelOutput {

    // MARK: Properties

    // Public

    let conferenceMetaData: ConferenceMetaData
    var conferenceEditions = BehaviorRelay<[ConferenceEdition]>(value: [])
    lazy var didSelectConferenceEditionTrigger: AnyObserver<ConferenceEdition> = showConferenceEditionAction.inputs

    // Private

    private lazy var showConferenceEditionAction = Action<ConferenceEdition, Void> { [unowned self] conferenceEdition in
        self.router.rx.trigger(.conferenceEditionDetail(self.conferenceMetaData, conferenceEdition))
    }

    private let router: AnyRouter<ConferencesRoute>

    // MARK: Initialization

    public init(conferenceMetaData: ConferenceMetaData, router: AnyRouter<ConferencesRoute>, engine: Engine) {
        self.conferenceMetaData = conferenceMetaData
        self.router = router
        super.init(engine: engine)
    }

    // MARK: APIs

    public func loadData() {
        conferencesService.conference(with: conferenceMetaData)
            .done { conferenceDetail in
                self.conferenceEditions.accept(conferenceDetail.editions)
            }.catch { error in
                print(error)
            }
    }
}

// MARK: - Dependencies

extension ConferenceDetailViewModel {

    var conferencesService: ConferencesService {
        return engine.serviceRegistry.resolve(type: ConferencesService.self)
    }
}
