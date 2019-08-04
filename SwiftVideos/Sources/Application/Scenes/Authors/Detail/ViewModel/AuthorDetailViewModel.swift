//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcNotificationBanner
import SuperArcStateView
import SuperArcCoreUI
import SuperArcCore
import XCoordinator
import Action
import RxCocoa
import RxSwift

protocol AuthorDetailViewModelInput {
    var authorMetaData: AuthorMetaData { get }
}

protocol AuthorDetailViewModelOutput {
    var authorDetail: BehaviorRelay<AuthorDetail?> { get }
}

class AuthorDetailViewModel: ViewModel {

    // MARK: Properties

    // Public

    var authorDetail = BehaviorRelay<AuthorDetail?>(value: nil)
    var toogleStateView = PublishSubject<StandardStateViewContext?>()
    var notification = PublishSubject<SuperArcNotificationBanner.Notification?>()

    // Private

    private var authorMetaData: AuthorMetaData
    private let router: AnyRouter<AuthorsRoute>

    // MARK: Initialization

    init(authorMetaData: AuthorMetaData, router: AnyRouter<AuthorsRoute>, engine: Engine) {
        self.authorMetaData = authorMetaData
        self.router = router
        super.init(engine: engine)
    }

    // MARK: APIs

    func loadData() {
        authorsService.fetchAuthor(with: authorMetaData)
            .done { [weak self] author in
                self?.authorDetail.accept(author)
            }
            .catch { [weak self] error in
                self?.toogleStateView.onNext(StandardStateViewContext(headline: "Author not found"))
                self?.notification.onNext(StandardNotification(error: error))
            }
    }

    func avatarImage(of author: AuthorMetaData) -> UIImage? {

        guard let avatarImageURL = authorsService.avatar(of: author) else {
            return nil
        }

        guard let avatarImage = UIImage(contentsOfFile: avatarImageURL.path) else {
            return nil
        }

        return avatarImage
    }
}

// MARK: - Dependencies

extension AuthorDetailViewModel {

    var authorsService: AuthorsService {
        return engine.serviceRegistry.resolve(type: AuthorsService.self)
    }
}
