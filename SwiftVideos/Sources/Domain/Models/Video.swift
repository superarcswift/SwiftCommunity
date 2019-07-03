//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

struct Video: Codable {
    let uuid: UUID
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
        case rawValue
        case associatedValue
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let rawValue = try container.decode(Int.self, forKey: .rawValue)

        switch rawValue {
        case 0:
            let id = try container.decode(String.self, forKey: .associatedValue)
            self = .youtube(id: id)

        case 1:
            let url = try container.decode(String.self, forKey: .associatedValue)
            self = .wwdc(url: url)

        case 2:
            let url = try container.decode(String.self, forKey: .associatedValue)
            self = .url(url: url)

        default:
            throw CodingError.unknownValue
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)

        switch self {
        case .youtube(let id):
            try container.encode(0, forKey: .rawValue)
            try container.encode(id, forKey: .associatedValue)

        case .wwdc(let url):
            try container.encode(1, forKey: .rawValue)
            try container.encode(url, forKey: .associatedValue)

        case .url(let url):
            try container.encode(2, forKey: .rawValue)
            try container.encode(url, forKey: .associatedValue)

        }
    }
}

enum CodingError: Error {
    case unknownValue
}
