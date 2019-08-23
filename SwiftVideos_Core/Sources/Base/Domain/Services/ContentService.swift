//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore
import PromiseKit

protocol ContentService: Service {
    associatedtype ContentType
    func fetchList() -> Promise<[ContentType]>
}

enum ContentServiceError: Error {
    case parsingException
}
