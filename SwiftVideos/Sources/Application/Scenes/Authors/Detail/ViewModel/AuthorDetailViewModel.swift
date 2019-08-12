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

class AuthorDetailViewModel: CoordinatedDIViewModel<AuthorsRoute, AuthorsDependency>, AuthorDetailViewModelInput, AuthorDetailViewModelOutput {

    // MARK: Properties

    // Public

    var authorDetail = BehaviorRelay<AuthorDetail?>(value: nil)
    var videos = BehaviorRelay<[VideoMetaData]?>(value: nil)
    var toogleStateView = PublishSubject<StandardStateViewContext?>()
    var toogleVideosStateView = PublishSubject<StandardStateViewContext?>()
    var notification = PublishSubject<SuperArcNotificationBanner.Notification?>()

    // Private

    var authorMetaData: AuthorMetaData

    // MARK: Initialization

    init(authorMetaData: AuthorMetaData, router: AnyRouter<AuthorsRoute>, dependency: AuthorsDependency) {
        self.authorMetaData = authorMetaData
        super.init(router: router, dependency: dependency)
    }

    // MARK: APIs

    func loadData() {
        dependency.authorsService.fetchAuthor(with: authorMetaData)
            .done { [weak self] author in
                self?.authorDetail.accept(author)
            }
            .catch { [weak self] error in
                self?.toogleStateView.onNext(StandardStateViewContext(headline: error.localizedDescription))
                self?.notification.onNext(StandardNotification(error: error))
            }

        dependency.videosService.fetchVideo(page: 1, author: authorMetaData)
            .done { [weak self] videos in
                self?.videos.accept(videos)
            }
            .catch { [weak self] error in
                self?.toogleVideosStateView.onNext(StandardStateViewContext(headline: error.localizedDescription))
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

    func previewImage(for video: VideoMetaData) -> UIImage? {

        guard let previewImageURL = dependency.videosService.previewImageURL(for: video) else {
            return UIImage(named: "video_preview_default")
        }

        guard let previewImage = UIImage(contentsOfFile: previewImageURL.path) else {
            return UIImage(named: "video_preview_default")
        }

        return previewImage
    }

    func present(_ video: VideoMetaData) {
        router.trigger(.videoDetail(video))
    }

}
