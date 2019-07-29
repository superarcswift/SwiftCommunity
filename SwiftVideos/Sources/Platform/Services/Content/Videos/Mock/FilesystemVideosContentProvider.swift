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

    public func fetchList() -> Promise<[Video]> {
        return Promise { resolver in
            do {
                let videosFileURL = baseFolderURL
                                        .appendingPathComponent("videos", isDirectory: true)
                                        .appendingPathComponent("videos.json")
                let videosList = try decode([Video].self, from: videosFileURL)

                resolver.fulfill(videosList)
            } catch {
                resolver.reject(error)
            }
        }
    }

    public func fetchList(of conference: ConferenceMetaData, in edition: ConferenceEdition) -> Promise<[Video]> {
        return Promise { resolver in
            do {
                let videosFileURL = baseFolderURL
                                        .appendingPathComponent("conferences", isDirectory: true)
                                        .appendingPathComponent("\(conference.id)", isDirectory: true)
                                        .appendingPathComponent("\(edition.year)", isDirectory: true)
                                        .appendingPathComponent("videos.json")
                let videosList = try decode([Video].self, from: videosFileURL)

                resolver.fulfill(videosList)
            } catch {
                resolver.reject(error)
            }
        }
    }
}
