//
//  Created by An Tran on 26.08.19.
//

import Files

protocol LicensesScanner {
    func scan(rootCarthageFolderPath: String) throws -> [File]
}

class CarthageLicensesScanner: LicensesScanner {

    enum LicenseFile: String, CaseIterable {
        case type1 = "License"
        case type2 = "License.md"
        case type3 = "LICENSE"
        case type4 = "LICENSE.md"

        static func find(in folder: Folder) -> File? {
            return folder.files.filter { item in
                guard LicenseFile(rawValue: item.name) != nil else {
                    return false
                }
                return true
            }.first
        }
    }

    // MARK: APIs

    func scan(rootCarthageFolderPath: String) throws -> [File] {
        let folder = try Folder(path: rootCarthageFolderPath)
        let subfolders = folder.makeSubfolderSequence(recursive: false)
        return subfolders.compactMap { subfolder in
            return LicenseFile.find(in: subfolder)
        }
    }
}
