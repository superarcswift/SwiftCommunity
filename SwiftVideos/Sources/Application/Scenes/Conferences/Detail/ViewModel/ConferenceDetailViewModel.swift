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

public protocol ConferenceDetailViewModelInput {
    var conferenceMetaData: ConferenceMetaData { get }
    var didSelectConferenceEditionTrigger: AnyObserver<ConferenceEdition> { get }
}

public protocol ConferenceDetailViewModelOutput {
    var conferenceEditions: BehaviorRelay<[ConferenceEdition]> { get set }
}

class ConferenceDetailViewModel: CoordinatedDIViewModel<ConferencesRoute, ConferencesDependency>, ConferenceDetailViewModelInput, ConferenceDetailViewModelOutput {

    // MARK: Properties

    // Public

    public let conferenceMetaData: ConferenceMetaData
    public var conferenceEditions = BehaviorRelay<[ConferenceEdition]>(value: [])
    public lazy var didSelectConferenceEditionTrigger: AnyObserver<ConferenceEdition> = showConferenceEditionAction.inputs

    public var toogleStateView = PublishSubject<StandardStateViewContext?>()
    public var notification = PublishSubject<SuperArcNotificationBanner.Notification?>()

    // Private

    private lazy var showConferenceEditionAction = Action<ConferenceEdition, Void> { [unowned self] conferenceEdition in
        self.router.rx.trigger(.conferenceEditionDetail(self.conferenceMetaData, conferenceEdition))
    }

    // MARK: Initialization

    init(conferenceMetaData: ConferenceMetaData, router: AnyRouter<ConferencesRoute>, dependency: ConferencesDependency, engine: Engine) {
        self.conferenceMetaData = conferenceMetaData
        super.init(router: router, dependency: dependency, engine: engine)
    }

    // MARK: APIs

    func loadData() {
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
