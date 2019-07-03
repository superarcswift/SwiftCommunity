//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore
import PromiseKit

protocol ContentService: Service {
    func fetchAllConferences() -> Promise<[Conference]>
}
