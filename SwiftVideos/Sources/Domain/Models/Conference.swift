//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

typealias ConferenceID = String

public struct ConferenceMetaData: Codable {
    let id: ConferenceID
    let name: String
}

public struct ConferenceEdition: Codable {
    let year: Int
}

public struct ConferenceDetail: Codable {
    let meta: ConferenceMetaData
    let editions: [ConferenceEdition]
}
