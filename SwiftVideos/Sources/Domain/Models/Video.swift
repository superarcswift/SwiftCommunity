//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

typealias VideoID = String

struct Video: Codable {
    let id: VideoID
    let name: String
    let source: VideoSource
}

enum VideoSource {
    case youtube(id: String)
    case wwdc(url: String)
    case url(url: String)
}

extension VideoSource: Codable {

    enum Key: CodingKey {
        case type
        case value
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let rawValue = try container.decode(String.self, forKey: .type)

        switch rawValue {
        case "youtube":
            let id = try container.decode(String.self, forKey: .value)
            self = .youtube(id: id)

        case "wwdc":
            let url = try container.decode(String.self, forKey: .value)
            self = .wwdc(url: url)

        case "url":
            let url = try container.decode(String.self, forKey: .value)
            self = .url(url: url)

        default:
            throw CodingError.unknownValue
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)

        switch self {
        case .youtube(let id):
            try container.encode(0, forKey: .type)
            try container.encode(id, forKey: .value)

        case .wwdc(let url):
            try container.encode(1, forKey: .type)
            try container.encode(url, forKey: .value)

        case .url(let url):
            try container.encode(2, forKey: .type)
            try container.encode(url, forKey: .value)

        }
    }
}

enum CodingError: Error {
    case unknownValue
}
