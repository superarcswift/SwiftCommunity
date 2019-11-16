//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

public typealias AuthorID = String

// MARK: - Author Detail

public struct AuthorDetail: Codable {
    public let metaData: AuthorMetaData
    public let resources: [AuthorResource]

    public init(metaData: AuthorMetaData, resources: [AuthorResource]) {
        self.metaData = metaData
        self.resources = resources
    }
}

public enum AuthorResource {
    case homepage(url: URL?)
    case github(url: URL?)
    case linkedin(url: URL?)

    public var type: String {
        switch self {
        case .homepage:
            return "Homepage"
        case .github:
            return "Github"
        case .linkedin:
            return "LinkedIn"
        }
    }

    public var value: String {
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

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
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

public typealias AuthorsList = [AuthorMetaData]

public struct AuthorMetaData: Codable, Equatable {
    public let id: String
    public let name: String
}
