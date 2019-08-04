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

    func fetchList() -> Promise<[AuthorMetaData]> {
        return contentProvider.fetchList()
    }

    func fetchAuthor(with metaData: AuthorMetaData) -> Promise<AuthorDetail> {
        return contentProvider.fetchAuthor(with: metaData)
    }

    func avatar(of author: AuthorMetaData) -> URL? {
        return contentProvider.avatar(of: author)
    }

    // MARK: Private helpers
}

// MARK: - AuthorsDataProvider

protocol AuthorsDataProvider: ContentDataProvider {
    func fetchList() -> Promise<[AuthorMetaData]>
    func fetchAuthor(with metaData: AuthorMetaData) -> Promise<AuthorDetail>
    func avatar(of author: AuthorMetaData) -> URL?
}
