//
//  Copyright © 2019 An Tran. All rights reserved.
//

import PromiseKit

class FilesystemAuthorsContentProvider: AuthorsDataProvider, FilesystemContentProvider {

    // MARK: Properties

    // Public

    var baseFolderPath: String

    // Private

    private lazy var baseFolderURL = URL(fileURLWithPath: baseFolderPath)
    private var fileManager = FileManager.default

    // MARK: Initialization

    init(rootContentFolderPath: String) {
        self.baseFolderPath = rootContentFolderPath
    }

    // MARK: APIs

    func fetchList() -> Promise<AuthorsList> {
        return Promise { resolver in
            do {
                let authorsFileURL = baseFolderURL
                    .appendingPathComponent("authors", isDirectory: true)
                    .appendingPathComponent("authors.json")
                let authorsList = try decode(AuthorsList.self, from: authorsFileURL)

                resolver.fulfill(authorsList)
            } catch {
                resolver.reject(error)
            }
        }
    }

    func fetchAuthor(with metaData: AuthorMetaData) -> Promise<AuthorDetail> {
        return Promise { resolver in
            do {
                let authorFileURL = baseFolderURL
                    .appendingPathComponent("authors", isDirectory: true)
                    .appendingPathComponent("\(metaData.id).json")
                let author = try decode(AuthorDetail.self, from: authorFileURL)

                resolver.fulfill(author)
            } catch {
                resolver.reject(error)
            }
        }
    }

    public func avatar(of authorMetaData: AuthorMetaData) -> URL? {
        let authorFolderURL = baseFolderURL
            .appendingPathComponent("authors", isDirectory: true)
        let previewFileURL = authorFolderURL.appendingPathComponent("\(authorMetaData.id).jpg")

        guard fileManager.fileExists(atPath: authorFolderURL.path) else {
            return nil
        }

        return previewFileURL
    }

}
