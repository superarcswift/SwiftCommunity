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
        return contentProvider.fetchList()
    }

    func fetchList(of conference: ConferenceMetaData, in edition: ConferenceEdition) -> Promise<[VideoMetaData]> {
        return contentProvider.fetchList(of: conference, in: edition)
    }

    func fetchVideo(with metaData: VideoMetaData) -> Promise<VideoDetail> {
        return contentProvider.fetchVideo(with: metaData)
    }

    func previewImageURL(for video: VideoMetaData) -> URL? {
        return contentProvider.previewImageURL(for: video)
    }
    // MARK: Private helpers
}

// MARK: - VideosDataProvider

protocol VideosDataProvider: ContentDataProvider {
    func fetchList() -> Promise<[VideoMetaData]>
    func fetchList(of conference: ConferenceMetaData, in edition: ConferenceEdition) -> Promise<[VideoMetaData]>
    func fetchVideo(with metaData: VideoMetaData) -> Promise<VideoDetail>
    func previewImageURL(for video: VideoMetaData) -> URL?
}
