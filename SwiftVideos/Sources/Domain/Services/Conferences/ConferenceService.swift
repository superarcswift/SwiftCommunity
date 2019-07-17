//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore
import PromiseKit

class ConferenceService: ContentService {

    // MARK: Properties

    // Public

    var context: ServiceContext

    // Private

    private var contentProvider: ConferenceDataProvider

    // MARK: Intialization

    init(context: ServiceContext, contentProvider: ConferenceDataProvider) {
        self.context = context
        self.contentProvider = contentProvider
    }

    // MARK: APIs

    func fetch() -> Promise<[Conference]> {
        return contentProvider.load()
    }

    // MARK: Private helpers
}

// MARK: ConferenceDataProvider

protocol ConferenceDataProvider {
    func load() -> Promise<[Conference]>
}
