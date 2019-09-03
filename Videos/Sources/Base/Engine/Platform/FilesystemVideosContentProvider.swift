//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import DataModels
import PromiseKit

public class FilesystemVideosContentProvider: VideosDataProvider, FilesystemContentProvider {

    // MARK: Properties

    // Public

    public var baseFolderPath: String

    // Private

    private lazy var baseFolderURL = URL(fileURLWithPath: baseFolderPath)
    private var fileManager = FileManager.default

    // MARK: Initialization

    public init(rootContentFolderPath: String) {
        self.baseFolderPath = rootContentFolderPath
    }

    // MARK: APIs

    /// Fetch all videos.
    public func fetchList(page: Int) -> Promise<[VideoMetaData]> {
        return Promise { resolver in
            do {
                let videosFileURL = baseFolderURL
                                        .appendingPathComponent("videos", isDirectory: true)
                                        .appendingPathComponent("videos-\(page).json")
                let videosList = try decode([VideoMetaData].self, from: videosFileURL)

                resolver.fulfill(videosList)
            } catch {
                resolver.reject(error)
            }
        }
    }

    /// Fetch and filter videos by conference.
    public func fetchList(conference: ConferenceMetaData, edition: ConferenceEdition) -> Promise<[VideoMetaData]> {
        return Promise { resolver in
            do {
                let videosFileURL = baseFolderURL
                                        .appendingPathComponent("conferences", isDirectory: true)
                                        .appendingPathComponent("\(conference.id)", isDirectory: true)
                                        .appendingPathComponent("\(edition.year)", isDirectory: true)
                                        .appendingPathComponent("videos.json")
                let videosList = try decode([VideoMetaData].self, from: videosFileURL)

                resolver.fulfill(videosList)
            } catch {
                resolver.reject(error)
            }
        }
    }

    /// Fetch detail information of a specific video.
    public func fetchVideo(metaData: VideoMetaData) -> Promise<VideoDetail> {
        return Promise { resolver in
            do {
                let videoFileURL = baseFolderURL
                                        .appendingPathComponent("conferences", isDirectory: true)
                                        .appendingPathComponent("\(metaData.conference.metaData.id)", isDirectory: true)
                                        .appendingPathComponent("\(metaData.conference.edition.year)", isDirectory: true)
                                        .appendingPathComponent("\(metaData.id).json")
                let videoDetail = try decode(VideoDetail.self, from: videoFileURL)

                resolver.fulfill(videoDetail)
            } catch {
                resolver.reject(error)
            }
        }
    }

    /// Fetch and filter videos by author.
    public func fetchList(page: Int, author: AuthorMetaData) -> Promise<[VideoMetaData]> {
        return fetchList(page: page).filterValues { videoMetaData -> Bool in
            return videoMetaData.authors.contains { $0 == author }
        }
    }

    /// Return URL to the preview image of a video.
    public func previewImageURL(for metaData: VideoMetaData) -> URL? {
        let videoFolderURL = baseFolderURL
                                .appendingPathComponent("conferences", isDirectory: true)
                                .appendingPathComponent("\(metaData.conference.metaData.id)", isDirectory: true)
                                .appendingPathComponent("\(metaData.conference.edition.year)", isDirectory: true)
        let previewFileURL = videoFolderURL.appendingPathComponent("\(metaData.id).jpg")
        if fileManager.fileExists(atPath: previewFileURL.path) {
            return previewFileURL
        }

        // Fallback to conference preview image
        let fallbackPreviewFileURL  = videoFolderURL.appendingPathComponent("\(metaData.conference.metaData.id)_\(metaData.conference.edition.year).jpg")
        if fileManager.fileExists(atPath: fallbackPreviewFileURL.path) {
            return fallbackPreviewFileURL
        }

        return previewFileURL
    }

}
