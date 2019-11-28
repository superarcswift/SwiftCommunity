//
//  Copyright © 2019 An Tran. All rights reserved.
//

import CoreUX
import RxDataSources

public enum ConferenceDetailSectionDataModel {
    case authors([AuthorViewModel])
    case video(VideoViewModel)
}

public struct ConferenceDetailSectionModel {
    public var items: [ConferenceDetailSectionDataModel]
}

extension ConferenceDetailSectionModel: SectionModelType {

    public init(original: ConferenceDetailSectionModel, items: [ConferenceDetailSectionDataModel]) {
        self = original
        self.items = items
    }
}
