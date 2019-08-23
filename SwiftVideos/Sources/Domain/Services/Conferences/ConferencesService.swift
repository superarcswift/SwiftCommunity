//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SwiftVideos_DataModels
import SuperArcCore
import PromiseKit

protocol HasConferencesService {
    var conferencesService: ConferencesService { get }
}

// MARK: - ConferencesServiceProtocol

protocol ConferenceServiceProtocol {
    func fetchList() -> Promise<[ConferenceMetaData]>
    func fetchVideos(conferenceMetaData: ConferenceMetaData) -> Promise<[[VideoMetaData]]>
    func conference(with metaData: ConferenceMetaData) -> Promise<ConferenceDetail>
    func bannerImageURL(for conference: ConferenceMetaData) -> URL?
}

// MARK: - ConferencesService

class ConferencesService: ContentService, ConferenceServiceProtocol {

    // MARK: Properties

    // Public

    var context: ServiceContext

    // Private

    private var contentProvider: ConferencesDataProvider
    private var videosService: VideosService

    // MARK: Intialization

    init(context: ServiceContext, contentProvider: ConferencesDataProvider, videosService: VideosService) {
        self.context = context
        self.contentProvider = contentProvider
        self.videosService = videosService
    }

    // MARK: APIs

    func fetchList() -> Promise<[ConferenceMetaData]> {
        return contentProvider.fetchList()
    }

    func conference(with metaData: ConferenceMetaData) -> Promise<ConferenceDetail> {
        return contentProvider.conference(with: metaData)
    }

    func fetchVideos(conferenceMetaData: ConferenceMetaData) -> Promise<[[VideoMetaData]]> {
        return conference(with: conferenceMetaData)
            .then { conferenceDetail -> Promise<[[VideoMetaData]]> in
                let promises = conferenceDetail.editions.map { self.videosService.fetchList(conference: conferenceMetaData, edition: $0) }
                return when(fulfilled: promises)
            }
    }

    func bannerImageURL(for conference: ConferenceMetaData) -> URL? {
        return contentProvider.bannerImageURL(for: conference)
    }

    // MARK: Private helpers
}

// MARK: - ConferencesDataProvider

protocol ConferencesDataProvider: ContentDataProvider {
    func fetchList() -> Promise<[ConferenceMetaData]>
    func conference(with metaData: ConferenceMetaData) -> Promise<ConferenceDetail>
    func bannerImageURL(for conference: ConferenceMetaData) -> URL?
}
