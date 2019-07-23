//
//  Copyright © 2019 An Tran. All rights reserved.
//

import XCoordinator
import SuperArcCoreUI
import SuperArcCore

class ConferenceDetailViewModel: ViewModel {

    // MARK: Properties

    // Public

    // Private

    private var conference: Conference
    private let router: AnyRouter<ConferencesRoute>

    // MARK: Initialization

    init(conference: Conference, router: AnyRouter<ConferencesRoute>, engine: Engine) {
        self.conference = conference
        self.router = router
        super.init(engine: engine)
    }
}
