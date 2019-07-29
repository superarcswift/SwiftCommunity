//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore
import PromiseKit

class AuthorsService: ContentService {

    // MARK: Properties

    // Public

    var context: ServiceContext

    // Private

    private var contentProvider: AuthorsDataProvider

    // MARK: Intialization

    init(context: ServiceContext, contentProvider: AuthorsDataProvider) {
        self.context = context
        self.contentProvider = contentProvider
    }

    // MARK: APIs

    func fetchList() -> Promise<[Author]> {
        return contentProvider.fetchList()
    }

    // MARK: Private helpers
}

// MARK: - AuthorsDataProvider

protocol AuthorsDataProvider: ContentDataProvider {
    func fetchList() -> Promise<[Author]>
}
