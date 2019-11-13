//
//  Copyright © 2019 An Tran. All rights reserved.
//

import CoreUX
import RxDataSources

public struct OpenConferenceSectionModel {
    public var year: Int
    public var items: [OpenConference]
}

extension OpenConferenceSectionModel: SectionModelType {

    public init(original: OpenConferenceSectionModel, items: [OpenConference]) {
        self = original
        self.items = items
    }
}
