//
//  Copyright © 2019 An Tran. All rights reserved.
//

import DataModels
import PromiseKit

public protocol HasAuthorsService {
    var authorsService: AuthorsServiceProtocol { get }
}

public protocol AuthorsServiceProtocol {
    func fetchList() -> Promise<AuthorsList>
    func fetchAuthor(with metaData: AuthorMetaData) -> Promise<AuthorDetail>
    func avatar(of author: AuthorMetaData) -> URL?
}
