//
//  Copyright © 2019 An Tran. All rights reserved.
//

import RxDataSources

enum ConferenceDetailSectionModel {
    case videosSection(items: [VideoMetaData])
}

extension ConferenceDetailSectionModel: SectionModelType {

    init(original: ConferenceDetailSectionModel, items: [VideoMetaData]) {
        self = original
    }

    var items: [VideoMetaData] {
        switch self {
        case .videosSection(items: let items):
            return items
        }
    }
}
