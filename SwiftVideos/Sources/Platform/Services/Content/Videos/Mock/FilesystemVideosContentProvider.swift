//
//  Copyright © 2019 An Tran. All rights reserved.
//

import PromiseKit

class FilesystemVideosContentProvider: VideosDataProvider {

    func load() -> Promise<[Video]> {
        do {
            let url = Bundle.main.url(forResource: "videos", withExtension: "json")!
            let jsonDecoder = JSONDecoder()
            let fileData = try Data(contentsOf: url)
            let videosList = try jsonDecoder.decode([Video].self, from: fileData)

            return Promise.value(videosList)
        } catch {
            print(error.localizedDescription)
            return Promise.value([])
        }

    }
}
