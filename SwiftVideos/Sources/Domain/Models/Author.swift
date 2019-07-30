//
//  Copyright © 2019 An Tran. All rights reserved.
//


typealias AuthorID = String

// MARK: - AuthorMetaData

struct AuthorMetaData: Codable {
    let id: String
    let name: String
}

// MARK: - Author Detail

struct AuthorDetail {
    let metaData: AuthorMetaData
}
