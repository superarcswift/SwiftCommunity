//
//  Copyright © 2019 An Tran. All rights reserved.
//

import XCoordinator
import SuperArcCoreUI
import SuperArcCore
import RxSwift
import RxCocoa

protocol ConferenceDetailViewModelInput {
    var conferenceMetaData: ConferenceMetaData { get }
}

protocol ConferenceDetailViewModelOutput {
    var conference: BehaviorRelay<ConferenceDetail?> { get set }
}

public class ConferenceDetailViewModel: ViewModel, ConferenceDetailViewModelInput, ConferenceDetailViewModelOutput {

    // MARK: Properties

    // Public

    let conferenceMetaData: ConferenceMetaData
    var conference = BehaviorRelay<ConferenceDetail?>(value: nil)

    // Private

    private let router: AnyRouter<ConferencesRoute>

    // MARK: Initialization

    public init(conferenceMetaData: ConferenceMetaData, router: AnyRouter<ConferencesRoute>, engine: Engine) {
        self.conferenceMetaData = conferenceMetaData
        self.router = router
        super.init(engine: engine)
    }

    // MARK: APIs

    public func fetchData() {
        conferencesService.conference(with: conferenceMetaData)
            .done { conferenceDetail in
                self.conference.accept(conferenceDetail)
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
