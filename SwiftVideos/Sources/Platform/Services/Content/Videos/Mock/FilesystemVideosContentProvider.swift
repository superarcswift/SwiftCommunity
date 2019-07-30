//
//  Copyright © 2019 An Tran. All rights reserved.
//

import PromiseKit

class FilesystemVideosContentProvider: VideosDataProvider, FilesystemContentProvider {

    // MARK: Properties

    // Public

    var baseFolderPath: String

    // Private

    private lazy var baseFolderURL = URL(fileURLWithPath: baseFolderPath)
    private var fileManager = FileManager.default

    // MARK: Initialization

    init(rootContentFolderPath: String) {
        self.baseFolderPath = rootContentFolderPath
    }

    // MARK: APIs

    public func fetchList() -> Promise<[VideoMetaData]> {
        return Promise { resolver in
            do {
                let videosFileURL = baseFolderURL
                                        .appendingPathComponent("videos", isDirectory: true)
                                        .appendingPathComponent("videos.json")
                let videosList = try decode([VideoMetaData].self, from: videosFileURL)

                resolver.fulfill(videosList)
            } catch {
                resolver.reject(error)
            }
        }
    }

    public func fetchList(of conference: ConferenceMetaData, in edition: ConferenceEdition) -> Promise<[VideoMetaData]> {
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

    public func video(with metaData: VideoMetaData) -> Promise<VideoDetail> {
        return Promise { resolver in
            do {
                let videoFileURL = baseFolderURL
                                        .appendingPathComponent("conferences", isDirectory: true)
                                        .appendingPathComponent("\(metaData.conferenceMetaData.id)", isDirectory: true)
                                        .appendingPathComponent("\(metaData.conferenceEdition.year)", isDirectory: true)
                                        .appendingPathComponent("\(metaData.id).json")
                let videoDetail = try decode(VideoDetail.self, from: videoFileURL)

                resolver.fulfill(videoDetail)
            } catch {
                resolver.reject(error)
            }
        }
    }

    public func previewImageURL(for metaData: VideoMetaData) -> URL? {
        let videoFolderURL = baseFolderURL
                                .appendingPathComponent("conferences", isDirectory: true)
                                .appendingPathComponent("\(metaData.conferenceMetaData.id)", isDirectory: true)
                                .appendingPathComponent("\(metaData.conferenceEdition.year)", isDirectory: true)
        let previewFileURL = videoFolderURL.appendingPathComponent("\(metaData.id).jpg")

        guard fileManager.fileExists(atPath: videoFolderURL.path) else {
            return nil
        }

        return previewFileURL
    }

}
