//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation
import Foundation

public class FilesystemStore: StoreProtocol {

    // MARK: Properties

    // Static

    public static let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!.combinePath("app.filesystemstorage")

    // Public

    public var name: String

    // Private

    private let defaultFileManager = FileManager.default

    private let path: String

    private let options: Data.WritingOptions

    // MARK: Constructor

    public init(name: String, basePath: String = FilesystemStore.cachePath, options: Data.WritingOptions = [.atomic]) {
        self.name = name
        self.options = options
        self.path = basePath.combinePath(name)

        do {
            try createDirectory()
        } catch {
            preconditionFailure("failed to create cache folder")
        }
    }

    // MARK: APIs

    public func read(_ key: String) throws -> StoreValue? {
        return NSData(contentsOfFile: makeFilePath(key))
    }

    public func write(_ key: String, value: StoreValue) throws {
        try? delete(key)
        let nsData = value.data as NSData
        try nsData.write(toFile: makeFilePath(key), options: options)
    }

    public func delete(_ key: String) throws {
        let path = makeFilePath(key)
        guard defaultFileManager.fileExists(atPath: path) else {
            return
        }
        try defaultFileManager.removeItem(atPath: path)
    }

    public func reset() throws {
        try defaultFileManager.removeItem(atPath: path)
        try createDirectory()
    }

    public var keys: Set<String> {
        fatalError("not supported")
    }

    enum FileErrors: Error {
        case fileNotFound
    }

    // MARK: Private helpers

    private func makeFilePath(_ key: String) -> String {
        return path.combinePath(key)
    }

    private func createDirectory() throws {
        try defaultFileManager.createDirectory(atPath: path, withIntermediateDirectories: true)
    }

}
