//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SwiftVideos_DataModels
import SuperArcCore
import PromiseKit

public protocol HasVideosService {
    var videosService: VideosServiceProtocol { get }
}

public protocol VideosServiceProtocol {
    func fetchList() -> Promise<[VideoMetaData]>
    func fetchList(conference: ConferenceMetaData, edition: ConferenceEdition) -> Promise<[VideoMetaData]>
    func fetchVideo(metaData: VideoMetaData) -> Promise<VideoDetail>
    func fetchVideo(page: Int, author: AuthorMetaData) -> Promise<[VideoMetaData]>
    func previewImageURL(for video: VideoMetaData) -> URL?
}

public class VideosService: Service, VideosServiceProtocol {

    // MARK: Properties

    // Public

    public var context: ServiceContext

    // Private

    private var contentProvider: VideosDataProvider

    // MARK: Intialization

    public init(context: ServiceContext, contentProvider: VideosDataProvider) {
        self.context = context
        self.contentProvider = contentProvider
    }

    // MARK: APIs

    public func fetchList() -> Promise<[VideoMetaData]> {
        return contentProvider.fetchList(page: 1)
    }

    public func fetchList(conference: ConferenceMetaData, edition: ConferenceEdition) -> Promise<[VideoMetaData]> {
        return contentProvider.fetchList(conference: conference, edition: edition)
    }

    public func fetchVideo(metaData: VideoMetaData) -> Promise<VideoDetail> {
        return contentProvider.fetchVideo(metaData: metaData)
    }

    public func fetchVideo(page: Int, author: AuthorMetaData) -> Promise<[VideoMetaData]> {
        return contentProvider.fetchList(page: page, author: author)
    }

    public func previewImageURL(for video: VideoMetaData) -> URL? {
        return contentProvider.previewImageURL(for: video)
    }

    // MARK: Private helpers
}

// MARK: - VideosDataProvider

public protocol VideosDataProvider: ContentDataProvider {

    func fetchList(page: Int) -> Promise<[VideoMetaData]>
    func fetchList(conference: ConferenceMetaData, edition: ConferenceEdition) -> Promise<[VideoMetaData]>
    func fetchVideo(metaData: VideoMetaData) -> Promise<VideoDetail>
    func fetchList(page: Int, author: AuthorMetaData) -> Promise<[VideoMetaData]>

    func previewImageURL(for video: VideoMetaData) -> URL?
}
