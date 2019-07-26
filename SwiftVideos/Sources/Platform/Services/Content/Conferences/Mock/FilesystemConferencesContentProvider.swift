//
//  Copyright © 2019 An Tran. All rights reserved.
//

import PromiseKit

public class FilesystemConferencesContentProvider: ConferencesDataProvider {

    // MARK: Properties

    // Public

    var baseFolderPath: String

    // Private

    private lazy var rootDocumentURL = URL(fileURLWithPath: baseFolderPath)
    private var fileManager = FileManager.default

    // MARK: Initialization

    public init(rootFolderPath: String) {
        self.baseFolderPath = rootFolderPath.combinePath("conferences")
    }

    // MARK: APIs

    public func load() -> Promise<[Conference]> {
        do {
            let conferecesFileURL = rootDocumentURL.appendingPathComponent("conferences.json")
            print(conferecesFileURL.absoluteString)
            let jsonDecoder = JSONDecoder()
            let fileData = try Data(contentsOf: conferecesFileURL)
            let conferenceList = try jsonDecoder.decode([Conference].self, from: fileData)

            return Promise.value(conferenceList)
        } catch {
            print(error.localizedDescription)
            return Promise.value([])
        }
    }

    public func bannerImageURL(for conference: Conference) -> URL? {
        let conferenceFolderURL = rootDocumentURL.appendingPathComponent(conference.id, isDirectory: true)
        let bannerFileURL = conferenceFolderURL.appendingPathComponent("cover.png")

        guard fileManager.fileExists(atPath: conferenceFolderURL.path) else {
            return nil
        }

        return bannerFileURL
    }

    // MARK: Private helpers
}
