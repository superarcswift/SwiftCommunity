//
//  Copyright © 2019 An Tran. All rights reserved.
//

import CoreUX

import RxDataSources

public enum ConferenceDetailSectionModel {
    case videosSection(items: [VideoViewModel])
}

extension ConferenceDetailSectionModel: SectionModelType {

    public init(original: ConferenceDetailSectionModel, items: [VideoViewModel]) {
        self = original
    }

    public var items: [VideoViewModel] {
        switch self {
        case .videosSection(items: let items):
            return items
        }
    }
}
