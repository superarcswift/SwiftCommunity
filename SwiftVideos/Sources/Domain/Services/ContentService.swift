//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore
import PromiseKit

protocol ContentService: Service {
    associatedtype ContentType

    func fetch() -> Promise<[ContentType]>
}
