//
//  Copyright © 2019 An Tran. All rights reserved.
//

import PromiseKit
import SuperArcCore

class MockConferenceContentService: ContentService {

    var context: ServiceContext

    // MARK: Intialization

    init(context: ServiceContext) {
        self.context = context
    }

    // MARK: APIs

    func fetch() -> Promise<[Conference]> {
        let conferences = decode("conferences")
        return Promise.value(conferences)
    }

    // MARK: Private helpers

    private func decode(_ file: String) -> [Conference] {
        do {
            let url = Bundle.main.url(forResource: file, withExtension: ".json")!
            let jsonDecoder = JSONDecoder()
            let fileData = try Data(contentsOf: url)
            let imageList = try jsonDecoder.decode([Conference].self, from: fileData)

            return imageList
        } catch {
            return []
        }
    }
}
