//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SwiftVideos_DataModels
import SuperArcCoreUI
import SuperArcCore

class ConferenceViewModel: ViewModel {

    // MARK: Properties

    // Public

    var conferenceMetaData: ConferenceMetaData

    var name: String {
        return conferenceMetaData.name
    }

    var bannerImage: UIImage? {
        guard let bannerImageURL = conferencesService.bannerImageURL(for: conferenceMetaData) else {
            return nil
        }

        guard let bannerImage = UIImage(contentsOfFile: bannerImageURL.path) else {
            return nil
        }

        return bannerImage
    }
    // Private

    private var conferencesService: ConferencesService

    // MARK: Initialization

    init(conferenceMetaData: ConferenceMetaData, conferencesService: ConferencesService) {
        self.conferenceMetaData = conferenceMetaData
        self.conferencesService = conferencesService
        super.init()
    }
}
