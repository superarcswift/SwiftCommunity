//
//  Copyright © 2019 An Tran. All rights reserved.
//

import PromiseKit

public class FilesystemConferencesContentProvider: ConferencesDataProvider, FilesystemContentProvider {

    // MARK: Properties

    // Public

    var baseFolderPath: String

    // Private

    private lazy var baseFolderURL = URL(fileURLWithPath: baseFolderPath)
    private var fileManager = FileManager.default

    // MARK: Initialization

    public init(rootContentFolderPath: String) {
        self.baseFolderPath = rootContentFolderPath.combinePath("conferences")
    }

    // MARK: APIs

    public func fetchList() -> Promise<[ConferenceMetaData]> {
        return Promise { resolver in
            do {
                let conferecesFileURL = baseFolderURL.appendingPathComponent("conferences.json")
                let conferencesList = try decode([ConferenceMetaData].self, from: conferecesFileURL)

                resolver.fulfill(conferencesList)
            } catch {
                resolver.reject(error)
            }
        }
    }

    public func conference(with conferenceMetaData: ConferenceMetaData) -> Promise<ConferenceDetail> {
        return Promise { resolver in
            let conferenceFileURL = baseFolderURL.appendingPathComponent(conferenceMetaData.id, isDirectory: true).appendingPathComponent("conference.json")
            let conferenceDetail = try decode(ConferenceDetail.self, from: conferenceFileURL)

            return resolver.fulfill(conferenceDetail)
        }
    }

    public func bannerImageURL(for conference: ConferenceMetaData) -> URL? {
        let conferenceFolderURL = baseFolderURL.appendingPathComponent(conference.id, isDirectory: true)
        let bannerFileURL = conferenceFolderURL.appendingPathComponent("cover.png")

        guard fileManager.fileExists(atPath: conferenceFolderURL.path) else {
            return nil
        }

        return bannerFileURL
    }

    // MARK: Private helpers
}
