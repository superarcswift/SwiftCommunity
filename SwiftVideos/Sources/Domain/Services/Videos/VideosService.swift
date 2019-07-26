//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore
import PromiseKit

class VideosService: ContentService {

    // MARK: Properties

    // Public

    var context: ServiceContext

    // Private

    private var contentProvider: VideosDataProvider

    // MARK: Intialization

    init(context: ServiceContext, contentProvider: VideosDataProvider) {
        self.context = context
        self.contentProvider = contentProvider
    }

    // MARK: APIs

    func fetch() -> Promise<[Video]> {
        return contentProvider.load()
    }

    // MARK: Private helpers
}

// MARK: - VideosDataProvider

protocol VideosDataProvider: ContentDataProvider {
    func load() -> Promise<[Video]>
}
