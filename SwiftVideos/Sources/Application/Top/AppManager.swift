//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore

class AppManager {

    // MARK: Properties

    // Public

    lazy var core: Core = {
        return Core()
    }()

    // Private

    // MARK: Intialization

    init() {
        let conferenceService = ConferenceService(context: core.engine.serviceContext, contentProvider: FilesystemConferenceContentProvider())
        core.engine.serviceRegistry.register(conferenceService, for: ConferenceService.self)
    }
}
