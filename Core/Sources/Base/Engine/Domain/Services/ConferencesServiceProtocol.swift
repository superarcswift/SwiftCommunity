//
//  Copyright © 2019 An Tran. All rights reserved.
//

import DataModels
import PromiseKit

public protocol HasConferencesService {
    var conferencesService: ConferencesServiceProtocol { get }
}

public protocol ConferencesServiceProtocol {
    func fetchList() -> Promise<[ConferenceMetaData]>
    func fetchVideos(conferenceMetaData: ConferenceMetaData) -> Promise<[[VideoMetaData]]>
    func conference(with metaData: ConferenceMetaData) -> Promise<ConferenceDetail>
    func bannerImageURL(for conference: ConferenceMetaData) -> URL?
}
