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

    func fetch() -> Promise<[Conference]> {
        return contentProvider.load()
    }

    func bannerImageURL(for conference: Conference) -> URL? {
        return contentProvider.bannerImageURL(for: conference)
    }

    // MARK: Private helpers
}

// MARK: - ConferencesDataProvider

protocol ConferencesDataProvider {
    func load() -> Promise<[Conference]>
    func bannerImageURL(for conference: Conference) -> URL?
}
