//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

/// Protocol defining  methods used by all filesystem-based content providers.
public protocol FilesystemContentProvider {
    var baseFolderPath: String { get set }
}

extension FilesystemContentProvider where Self: ContentDataProvider {

    public func decode<T: Codable>(_ type: T.Type, from localFileURL: URL) throws -> T {
        let jsonDecoder = JSONDecoder()
        let fileData = try Data(contentsOf: localFileURL)
        let value = try jsonDecoder.decode(T.self, from: fileData)

        return value
    }
}
