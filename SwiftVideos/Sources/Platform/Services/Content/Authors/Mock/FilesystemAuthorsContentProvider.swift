//
//  Copyright © 2019 An Tran. All rights reserved.
//

import PromiseKit

class FilesystemAuthorsContentProvider: AuthorsDataProvider, FilesystemContentProvider {

    // MARK: Properties

    // Public

    var baseFolderPath: String

    // MARK: Initialization

    init(rootFolderPath: String) {
        self.baseFolderPath = rootFolderPath
    }

    // MARK: APIs

    func load() -> Promise<[Author]> {
        return Promise { resolver in
            do {
                let authorsFileURL = Bundle.main.url(forResource: "authors", withExtension: "json")!
                let authorsList = try decode([Author].self, from: authorsFileURL)

                resolver.fulfill(authorsList)
            } catch {
                resolver.reject(error)
            }
        }
    }
}
