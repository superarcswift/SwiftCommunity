//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import RxSwift
import RxCocoa

class VideosCollectionViewModel: ViewModel {

    // MARK: Properties

    var conferences = BehaviorRelay<[Conference]>(value: [])

    // MARK: APIs

    func loadData() {
        conferenceService.fetch()
            .done { [weak self] conferences in
                self?.conferences.accept(conferences)
            }
            .catch { error in
                print(error)
        }
    }
}

extension VideosCollectionViewModel {

    var conferenceService: ConferenceService {
        return engine.serviceRegistry.resolve(type: ConferenceService.self)
    }
}
