//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

public typealias ConferenceID = String

public typealias ConferencesList = [ConferenceMetaData]

public struct ConferenceMetaData: Codable {
    public let id: ConferenceID
    public let name: String
}

public struct ConferenceEdition: Codable {
    public let year: Int
}

public struct ConferenceDetail: Codable {
    public let meta: ConferenceMetaData
    public let editions: [ConferenceEdition]
}
