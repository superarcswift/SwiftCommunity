//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore
import PromiseKit

class VideosService: ContentService {

    // MARK: Properties

    // Public

    var context: ServiceContext

    // Private

    private var contentProvider: VideosDataProvider

    // MARK: Intialization

    init(context: ServiceContext, contentProvider: VideosDataProvider) {
        self.context = context
        self.contentProvider = contentProvider
    }

    // MARK: APIs

    func fetchList() -> Promise<[VideoMetaData]> {
        return contentProvider.fetchList(page: 1)
    }

    func fetchList(conference: ConferenceMetaData, edition: ConferenceEdition) -> Promise<[VideoMetaData]> {
        return contentProvider.fetchList(conference: conference, edition: edition)
    }

    func fetchVideo(metaData: VideoMetaData) -> Promise<VideoDetail> {
        return contentProvider.fetchVideo(metaData: metaData)
    }

    func fetchVideo(page: Int, author: AuthorMetaData) -> Promise<[VideoMetaData]> {
        return contentProvider.fetchList(page: page, author: author)
    }

    func previewImageURL(for video: VideoMetaData) -> URL? {
        return contentProvider.previewImageURL(for: video)
    }

    // MARK: Private helpers
}

// MARK: - VideosDataProvider

protocol VideosDataProvider: ContentDataProvider {

    func fetchList(page: Int) -> Promise<[VideoMetaData]>
    func fetchList(conference: ConferenceMetaData, edition: ConferenceEdition) -> Promise<[VideoMetaData]>
    func fetchVideo(metaData: VideoMetaData) -> Promise<VideoDetail>
    func fetchList(page: Int, author: AuthorMetaData) -> Promise<[VideoMetaData]>

    func previewImageURL(for video: VideoMetaData) -> URL?
}
