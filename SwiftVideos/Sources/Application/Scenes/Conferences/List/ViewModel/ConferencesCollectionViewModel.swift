//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import RxSwift
import RxCocoa

class ConferencesCollectionViewModel: ViewModel {

    // MARK: Properties

    // Public

    var conferences = BehaviorRelay<[Conference]>(value: [])
    var didSelect = PublishSubject<Conference>()

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

    func selectAt(_ index: Int) {
        guard index < conferences.value.count else {
            print("no element found at \(index)")
            return
        }

        let conference = conferences.value[index]

        didSelect.on(.next(conference))
    }
}

// MARK: Dependencies

extension ConferencesCollectionViewModel {

    var conferencesService: ConferencesService {
        return engine.serviceRegistry.resolve(type: ConferencesService.self)
    }
}
