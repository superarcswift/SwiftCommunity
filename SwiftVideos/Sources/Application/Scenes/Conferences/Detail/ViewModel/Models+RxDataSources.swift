//
//  Copyright © 2019 An Tran. All rights reserved.
//

import RxDataSources

enum ConferenceDetailSectionModel {
    case videosSection(items: [VideoViewModel])
}

extension ConferenceDetailSectionModel: SectionModelType {

    init(original: ConferenceDetailSectionModel, items: [VideoViewModel]) {
        self = original
    }

    var items: [VideoViewModel] {
        switch self {
        case .videosSection(items: let items):
            return items
        }
    }
}
