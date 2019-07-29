//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore
import PromiseKit

class ConferencesService: ContentService {

    // MARK: Properties

    // Public

    var context: ServiceContext

    // Private

    private var contentProvider: ConferencesDataProvider

    // MARK: Intialization

    init(context: ServiceContext, contentProvider: ConferencesDataProvider) {
        self.context = context
        self.contentProvider = contentProvider
    }

    // MARK: APIs

    func fetchList() -> Promise<[ConferenceMetaData]> {
        return contentProvider.fetchList()
    }

    func conference(with metaData: ConferenceMetaData) -> Promise<ConferenceDetail> {
        return contentProvider.conference(with: metaData)
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
