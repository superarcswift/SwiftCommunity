//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import SuperArcCoreUI

class DashboardViewModel: DIViewModel<AlgorithmDependency> {

    func loadData() {
        let service = AlgorithmService(context: dependency.serviceContext)
        service.fetchData()
            .done { section in
                print(section.title)
            }
            .catch { error in
                print(error)
            }
    }
}
