//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

typealias ConferenceID = String

typealias ConferencesList = [ConferenceMetaData]

struct ConferenceMetaData: Codable {
    let id: ConferenceID
    let name: String
}

struct ConferenceEdition: Codable {
    let year: Int
}

struct ConferenceDetail: Codable {
    let meta: ConferenceMetaData
    let editions: [ConferenceEdition]
}
