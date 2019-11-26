//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcFoundation
import PromiseKit

class ContentViewModel: ViewModel {

    // MARK: Properties

    let content: Content
    let algorithmService: AlgorithmService

    // MARK: Initialization

    init(content: Content, algorithmService: AlgorithmService) {
        self.content = content
        self.algorithmService = algorithmService
    }

    func load() -> Promise<String?> {
        switch content {
            case .local(_, let value):
                return Promise.value(value)
            case .url(_, let path):
                return loadContent(from: path)
        }
    }

    // MARK: Private helpers

    private func loadContent(from path: String) -> Promise<String?> {
        return algorithmService.loadContent(from: path)
    }

}
