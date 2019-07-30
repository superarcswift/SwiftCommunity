//
//  Copyright © 2019 An Tran. All rights reserved.
//

import PromiseKit

class FilesystemAuthorsContentProvider: AuthorsDataProvider, FilesystemContentProvider {

    // MARK: Properties

    // Public

    var baseFolderPath: String

    // MARK: Initialization

    init(rootContentFolderPath: String) {
        self.baseFolderPath = rootContentFolderPath
    }

    // MARK: APIs

    func fetchList() -> Promise<[AuthorMetaData]> {
        return Promise { resolver in
            do {
                let authorsFileURL = Bundle.main.url(forResource: "authors", withExtension: "json")!
                let authorsList = try decode([AuthorMetaData].self, from: authorsFileURL)

                resolver.fulfill(authorsList)
            } catch {
                resolver.reject(error)
            }
        }
    }
}
