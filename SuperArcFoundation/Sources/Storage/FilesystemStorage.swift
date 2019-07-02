//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

public final class FilesystemStore: Storage {

    // MARK: Properties

    // Public

    public static let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!.combinePath("app.filesystemstore")

    public var name: String

    // Private

    private let path: String

    private let options: Data.WritingOptions

    // MARK: Initialization

    init?(name: String, basePath: String = FilesystemStore.cachePath, options: Data.WritingOptions = [.atomic]) {
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

    public func read(_ key: String) throws -> StorageValue? {
        do {
            let fileHandle = try makeFileHandle(key)

            fileHandle.seek(toFileOffset: 0)
            return fileHandle.readDataToEndOfFile()

        } catch FileErrors.fileNotFound {
            return nil

        } catch {
            throw error
        }
    }

    public func write(_ key: String, value: StorageValue) throws {
        do {
            let fileHandle = try makeFileHandle(key)

            fileHandle.seek(toFileOffset: 0)
            fileHandle.write(value.data)
            fileHandle.truncateFile(atOffset: fileHandle.offsetInFile)

        } catch FileErrors.fileNotFound {
            // MAY-FIX: rewrite using URLs instead of FilePaths
            let nsData = value.data as NSData
            try nsData.write(toFile: makeFilePath(key), options: options)

        } catch {
            throw error
        }
    }

    public func delete(_ key: String) throws {
        try FileManager.default.removeItem(atPath: makeFilePath(key))
    }

    public func reset() throws {
        try FileManager.default.removeItem(atPath: path)
        try createDirectory()
    }

    enum FileErrors: Error {
        case fileNotFound
    }

    // MARK: Private helpers

    private func makeFilePath(_ key: String) -> String {
        return path.combinePath(key)
    }

    private func makeFileHandle(_ key: String) throws -> FileHandle {
        guard let fileHandle = FileHandle(forUpdatingAtPath: makeFilePath(key)) else {
            throw FileErrors.fileNotFound
        }

        return fileHandle
    }

    private func createDirectory() throws {
        try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true)
    }
    
}
