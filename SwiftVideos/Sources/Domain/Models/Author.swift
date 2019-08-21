//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

typealias AuthorID = String

// MARK: - Author Detail

struct AuthorDetail: Codable {
    let metaData: AuthorMetaData
    let resources: [AuthorResource]
}

enum AuthorResource {
    case homepage(url: URL?)
    case github(url: URL?)
    case linkedin(url: URL?)

    var type: String {
        switch self {
        case .homepage:
            return "Homepage"
        case .github:
            return "Github"
        case .linkedin:
            return "LinkedIn"
        }
    }

    var value: String {
        switch self {
        case .homepage(let url):
            return url?.absoluteString ?? ""
        case .github(let url):
            return url?.absoluteString ?? ""
        case .linkedin(let url):
            return url?.absoluteString ?? ""
        }

    }
}

extension AuthorResource: Codable {

    enum Key: CodingKey {
        case type
        case value
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let rawValue = try container.decode(String.self, forKey: .type)

        switch rawValue {
        case "homepage":
            let url = try container.decode(String.self, forKey: .value)
            self = .homepage(url: URL(string: url))

        case "github":
            let url = try container.decode(String.self, forKey: .value)
            self = .github(url: URL(string: url))

        case "linkedin":
            let url = try container.decode(String.self, forKey: .value)
            self = .linkedin(url: URL(string: url))

        default:
            throw ModelCodingError.unknownValue
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)

        switch self {
        case .homepage(let url):
            try container.encode("homepage", forKey: .type)
            try container.encode(url, forKey: .value)

        case .github(let url):
            try container.encode("github", forKey: .type)
            try container.encode(url, forKey: .value)

        case .linkedin(let url):
            try container.encode("linkedin", forKey: .type)
            try container.encode(url, forKey: .value)

        }
    }
}

// MARK: - AuthorMetaData

typealias AuthorsList = [AuthorMetaData]

struct AuthorMetaData: Codable, Equatable {
    let id: String
    let name: String
}
