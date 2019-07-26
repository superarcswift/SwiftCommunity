//
//  Copyright © 2019 An Tran. All rights reserved.
//

import PromiseKit

class FilesystemAuthorsContentProvider: AuthorsDataProvider {

    // MARK: Properties

    // Public

    var rootFolderPath: String

    // MARK: Initialization

    init(rootFolderPath: String) {
        self.rootFolderPath = rootFolderPath
    }

    // MARK: APIs

    func load() -> Promise<[Author]> {
        do {
            let url = Bundle.main.url(forResource: "authors", withExtension: "json")!
            let jsonDecoder = JSONDecoder()
            let fileData = try Data(contentsOf: url)
            let authorsList = try jsonDecoder.decode([Author].self, from: fileData)

            return Promise.value(authorsList)
        } catch {
            print(error.localizedDescription)
            return Promise.value([])
        }

    }
}
