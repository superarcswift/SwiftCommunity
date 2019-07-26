//
//  Copyright © 2019 An Tran. All rights reserved.
//

import PromiseKit

class FilesystemVideosContentProvider: VideosDataProvider, FilesystemContentProvider {

    // MARK: Properties

    // Public

    var baseFolderPath: String

    // MARK: Initialization

    init(rootFolderPath: String) {
        self.baseFolderPath = rootFolderPath
    }

    // MARK: APIs

    func load() -> Promise<[Video]> {
        return Promise { resolver in
            do {
                let videoFileURL = Bundle.main.url(forResource: "videos", withExtension: "json")!
                let videosList = try decode([Video].self, from: videoFileURL)
                resolver.fulfill(videosList)
            } catch {
                resolver.reject(error)
            }
        }
    }
}
