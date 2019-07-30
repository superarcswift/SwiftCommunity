//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import XCoordinator
import Action
import RxSwift
import RxCocoa

class AuthorsCollectionViewModel: ViewModel {

    // MARK: Properties

    private let router: AnyRouter<AuthorsRoute>
    private lazy var showAuthorAction = Action<AuthorMetaData, Void> { [unowned self] video in
        self.router.rx.trigger(.authorDetail(video))
    }

    // Public

    lazy var didSelectAuthor: AnyObserver<AuthorMetaData> = showAuthorAction.inputs
    var authors = BehaviorRelay<[AuthorMetaData]>(value: [])

    // MARK: Initialization

    init(router: AnyRouter<AuthorsRoute>, engine: Engine) {
        self.router = router
        super.init(engine: engine)
    }

    // MARK: APIs

    func loadData() {
        authorsService.fetchList()
            .done { [weak self] authors in
                self?.authors.accept(authors)
            }
            .catch { error in
                print(error)
        }
    }
}

// MARK: - Dependencies

extension AuthorsCollectionViewModel {

    var authorsService: AuthorsService {
        return engine.serviceRegistry.resolve(type: AuthorsService.self)
    }
}
