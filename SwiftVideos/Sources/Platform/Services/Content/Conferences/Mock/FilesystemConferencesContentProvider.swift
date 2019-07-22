//
//  Copyright © 2019 An Tran. All rights reserved.
//

import PromiseKit

class FilesystemConferencesContentProvider: ConferencesDataProvider {

    func load() -> Promise<[Conference]> {
        do {
            let url = Bundle.main.url(forResource: "conferences", withExtension: "json")!
            let jsonDecoder = JSONDecoder()
            let fileData = try Data(contentsOf: url)
            let conferenceList = try jsonDecoder.decode([Conference].self, from: fileData)

            return Promise.value(conferenceList)
        } catch {
            print(error.localizedDescription)
            return Promise.value([])
        }

    }
}
