//
//  Copyright © 2019 An Tran. All rights reserved.
//

import DataModels
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
