//
//  Copyright © 2019 An Tran. All rights reserved.
//

import CoreUX
import RxDataSources

enum AlgorithmSectionDataModel {
    case content(Content)
    case section(Section)
}

struct AlgorithmSectionModel {
    public var items: [AlgorithmSectionDataModel]
}

extension AlgorithmSectionModel: SectionModelType {

    init(original: AlgorithmSectionModel, items: [AlgorithmSectionDataModel]) {
        self = original
        self.items = items
    }
}
