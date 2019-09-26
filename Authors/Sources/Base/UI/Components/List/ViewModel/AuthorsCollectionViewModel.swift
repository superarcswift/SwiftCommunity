//
//  Copyright © 2019 An Tran. All rights reserved.
//

import CoreUX
import Core
import SuperArcNotificationBanner
import SuperArcStateView
import SuperArcCoreUI
import SuperArcCore
import XCoordinator
import XCoordinatorRx
import Action
import RxSwift
import RxCocoa

protocol AuthorsCollectionViewModelInput {
    var didSelectAuthor: AnyObserver<AuthorViewModel> { get }
}

protocol AuthorsCollectionViewModelOutput {
    var authors: BehaviorRelay<[AuthorViewModel]> { get set }
}

protocol AuthorsCollectionViewModelApi {
    func loadData()
}

protocol AuthorsCollectionViewType {
    var inputs: AuthorsCollectionViewModelInput { get }
    var outputs: AuthorsCollectionViewModelOutput { get }
    var apis: AuthorsCollectionViewModelApi { get }
}

extension AuthorsCollectionViewType where Self: AuthorsCollectionViewModelInput & AuthorsCollectionViewModelOutput & AuthorsCollectionViewModelApi {

    var inputs: AuthorsCollectionViewModelInput {
        return self
    }

    var outputs: AuthorsCollectionViewModelOutput {
        return self
    }

    var apis: AuthorsCollectionViewModelApi {
        return self
    }
}

class AuthorsCollectionViewModel: CoordinatedDIViewModel<AuthorsRoute, AuthorsDependency>, AuthorsCollectionViewType, AuthorsCollectionViewModelInput, AuthorsCollectionViewModelOutput, AuthorsCollectionViewModelApi {

    // MARK: Properties

    private lazy var showAuthorAction = Action<AuthorViewModel, Void> { [unowned self] author in
        self.router.rx.trigger(.authorDetail(author.authorMetaData, false))
    }

    // Public

    lazy var didSelectAuthor: AnyObserver<AuthorViewModel> = showAuthorAction.inputs
    var authors = BehaviorRelay<[AuthorViewModel]>(value: [])

    var toogleStateView = PublishSubject<StandardStateViewContext?>()
    var notification = PublishSubject<SuperArcNotificationBanner.Notification?>()

    // MARK: APIs

    func loadData() {
        dependency.authorsService.fetchList()
            .mapValues {
                AuthorViewModel(authorMetaData: $0, authorsService: self.dependency.authorsService)
            }.done { [weak self] authors in
                self?.authors.accept(authors)
            }
            .catch { [weak self] error in
                self?.toogleStateView.onNext(StandardStateViewContext(headline: "No authors found"))
                self?.notification.onNext(StandardNotification(error: error))
            }
    }
}
