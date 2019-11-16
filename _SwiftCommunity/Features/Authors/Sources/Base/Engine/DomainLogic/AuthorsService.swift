//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import DataModels
import SuperArcCore
import PromiseKit

public class AuthorsService: Service, AuthorsServiceProtocol {

    // MARK: Properties

    // Public

    public var context: ServiceContext

    // Private

    private var contentProvider: AuthorsDataProvider

    // MARK: Intialization

    public init(context: ServiceContext, contentProvider: AuthorsDataProvider) {
        self.context = context
        self.contentProvider = contentProvider
    }

    // MARK: APIs

    public func fetchList() -> Promise<AuthorsList> {
        return contentProvider.fetchList()
    }

    public func fetchAuthor(with metaData: AuthorMetaData) -> Promise<AuthorDetail> {
        return contentProvider.fetchAuthor(with: metaData)
    }

    public func avatar(of author: AuthorMetaData) -> URL? {
        return contentProvider.avatar(of: author)
    }

    // MARK: Private helpers
}

// MARK: - AuthorsDataProvider

public protocol AuthorsDataProvider: ContentDataProvider {
    func fetchList() -> Promise<AuthorsList>
    func fetchAuthor(with metaData: AuthorMetaData) -> Promise<AuthorDetail>
    func avatar(of author: AuthorMetaData) -> URL?
}
