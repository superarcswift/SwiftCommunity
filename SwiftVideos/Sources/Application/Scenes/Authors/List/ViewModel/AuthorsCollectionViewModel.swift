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

protocol AuthorsCollectionViewModelInput {
    var didSelectAuthor: AnyObserver<AuthorMetaData> { get }
}

protocol AuthorsCollectionViewModelOutput {
    var authors: BehaviorRelay<[AuthorMetaData]> { get set }
}

protocol AuthorsCollectionViewModelApi {
    func loadData()
    func avatarImage(of author: AuthorMetaData) -> UIImage?
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

    private lazy var showAuthorAction = Action<AuthorMetaData, Void> { [unowned self] video in
        self.router.rx.trigger(.authorDetail(video))
    }

    // Public

    lazy var didSelectAuthor: AnyObserver<AuthorMetaData> = showAuthorAction.inputs
    var authors = BehaviorRelay<[AuthorMetaData]>(value: [])

    var toogleStateView = PublishSubject<StandardStateViewContext?>()
    var notification = PublishSubject<SuperArcNotificationBanner.Notification?>()

    // MARK: APIs

    func loadData() {
        dependency.authorsService.fetchList()
            .done { [weak self] authors in
                self?.authors.accept(authors)
            }
            .catch { [weak self] error in
                self?.toogleStateView.onNext(StandardStateViewContext(headline: "No authors found"))
                self?.notification.onNext(StandardNotification(error: error))
            }
    }

    func avatarImage(of author: AuthorMetaData) -> UIImage? {

        guard let avatarImageURL = dependency.authorsService.avatar(of: author) else {
            return nil
        }

        guard let avatarImage = UIImage(contentsOfFile: avatarImageURL.path) else {
            return nil
        }

        return avatarImage
    }
}
