//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SwiftVideos_Core
import SwiftVideos_DataModels
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
    var authorDetail: BehaviorRelay<AuthorDetail?> { get set }
    var authorViewModel: AuthorViewModel { get }
    var videos: BehaviorRelay<[VideoViewModel]?> { get set }
}

protocol AuthorDetailViewModelApi {
    func loadData()
    func avatarImage(of author: AuthorMetaData) -> UIImage?
    func present(_ video: VideoViewModel)
}

protocol AuthorDetailViewModelType {
    var inputs: AuthorDetailViewModelInput { get }
    var outputs: AuthorDetailViewModelOutput { get }
    var apis: AuthorDetailViewModelApi { get }
}

extension AuthorDetailViewModelType where Self: AuthorDetailViewModelInput & AuthorDetailViewModelOutput & AuthorDetailViewModelApi {

    var inputs: AuthorDetailViewModelInput {
        return self
    }

    var outputs: AuthorDetailViewModelOutput {
        return self
    }

    var apis: AuthorDetailViewModelApi {
        return self
    }
}

class AuthorDetailViewModel: CoordinatedDIViewModel<AuthorsRoute, AuthorsDependency>, AuthorDetailViewModelType, AuthorDetailViewModelInput, AuthorDetailViewModelOutput, AuthorDetailViewModelApi {

    // MARK: Properties

    // Public

    var authorDetail = BehaviorRelay<AuthorDetail?>(value: nil)

    var videos = BehaviorRelay<[VideoViewModel]?>(value: nil)
    var toogleStateView = PublishSubject<StandardStateViewContext?>()
    var toogleVideosStateView = PublishSubject<StandardStateViewContext?>()
    var notification = PublishSubject<SuperArcNotificationBanner.Notification?>()

    lazy var authorViewModel: AuthorViewModel = {
        return AuthorViewModel(authorMetaData: authorMetaData, authorsService: dependency.authorsService)
    }()

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
            }.catch { [weak self] error in
                guard let self = self else { return }
                let fallbackAuthorDetail = AuthorDetail(metaData: self.authorMetaData, resources: [])
                self.authorDetail.accept(fallbackAuthorDetail)
            }

        dependency.videosService.fetchVideo(page: 1, author: authorMetaData)
            .mapValues {
                VideoViewModel(videoMetaData: $0, videosService: self.dependency.videosService, authorsService: self.dependency.authorsService)
            }.done { [weak self] videos in
                self?.videos.accept(videos)
            }.catch { [weak self] error in
                self?.toogleVideosStateView.onNext(StandardStateViewContext(headline: error.localizedDescription))
            }
    }

    // TODO: use AuthorViewModel instead and remove this function.
    func avatarImage(of author: AuthorMetaData) -> UIImage? {

        guard let avatarImageURL = dependency.authorsService.avatar(of: author) else {
            return nil
        }

        guard let avatarImage = UIImage(contentsOfFile: avatarImageURL.path) else {
            return nil
        }

        return avatarImage
    }

    func present(_ video: VideoViewModel) {
        router.trigger(.videoDetail(video.videoMetaData))
    }

}
