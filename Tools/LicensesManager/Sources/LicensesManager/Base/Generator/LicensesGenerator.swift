//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Files

protocol OutputExporter {
    func export(from files: [File]) throws -> String
}

class PlistExporter: OutputExporter {

    func export(from files: [File]) throws -> String {
        return "123"
    }
}

protocol LicensesGenerator {
    associatedtype LicensesScannerType: LicensesScanner
    associatedtype OutputExporterType: OutputExporter

    var rootFolderPath: String { get }

    var scanner: LicensesScannerType { get }
    var generator: OutputExporterType { get }

    func generate() throws
}

class PlistCarthageLicensesGenerator: LicensesGenerator {
    let rootFolderPath: String
    let scanner: CarthageLicensesScanner
    let generator: PlistExporter

    init(rootFolderPath: String) {
        self.rootFolderPath = rootFolderPath
        self.scanner = CarthageLicensesScanner()
        self.generator = PlistExporter()
    }

    func generate() throws {
        let files = try scanner.scan(rootCarthageFolderPath: rootFolderPath)
        let result = try generator.export(from: files)
    }

}
