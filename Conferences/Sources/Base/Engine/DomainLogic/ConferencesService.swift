//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import DataModels
import SuperArcCore
import PromiseKit

// MARK: - ConferencesService

public class ConferencesService: Service, ConferencesServiceProtocol {

    // MARK: Properties

    // Public

    public var context: ServiceContext

    // Private

    private var contentProvider: ConferencesDataProvider
    private var videosService: VideosServiceProtocol

    // MARK: Intialization

    public init(context: ServiceContext, contentProvider: ConferencesDataProvider, videosService: VideosServiceProtocol) {
        self.context = context
        self.contentProvider = contentProvider
        self.videosService = videosService
    }

    // MARK: APIs

    public func fetchList() -> Promise<[ConferenceMetaData]> {
        return contentProvider.fetchList()
    }

    public func conference(with metaData: ConferenceMetaData) -> Promise<ConferenceDetail> {
        return contentProvider.conference(with: metaData)
    }

    public func fetchVideos(conferenceMetaData: ConferenceMetaData) -> Promise<[[VideoMetaData]]> {
        return conference(with: conferenceMetaData)
            .then { conferenceDetail -> Promise<[[VideoMetaData]]> in
                let promises = conferenceDetail.editions.map { self.videosService.fetchList(conference: conferenceMetaData, edition: $0) }
                return when(fulfilled: promises)
            }
    }

    public func bannerImageURL(for conference: ConferenceMetaData) -> URL? {
        return contentProvider.bannerImageURL(for: conference)
    }

    // MARK: Private helpers
}

// MARK: - ConferencesDataProvider

public protocol ConferencesDataProvider: ContentDataProvider {
    func fetchList() -> Promise<[ConferenceMetaData]>
    func conference(with metaData: ConferenceMetaData) -> Promise<ConferenceDetail>
    func bannerImageURL(for conference: ConferenceMetaData) -> URL?
}
