//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import RxSwift
import RxCocoa

class AuthorsCollectionViewModel: ViewModel {

    // MARK: Properties

    // Public

    var authors = BehaviorRelay<[Author]>(value: [])
    var didSelect = PublishSubject<Author>()

    // MARK: APIs

    func loadData() {
        authorsService.fetch()
            .done { [weak self] authors in
                self?.authors.accept(authors)
            }
            .catch { error in
                print(error)
        }
    }

    func selectAt(_ index: Int) {
        guard index < authors.value.count else {
            print("no author found at \(index)")
            return
        }

        let conference = authors.value[index]

        didSelect.on(.next(conference))
    }
}

// MARK: Dependencies

extension AuthorsCollectionViewModel {

    var authorsService: AuthorsService {
        return engine.serviceRegistry.resolve(type: AuthorsService.self)
    }
}
