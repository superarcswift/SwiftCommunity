//
//  Copyright © 2019 An Tran. All rights reserved.
//

import DataModels

class Section: Codable {
    let title: String
    let content: ContentType?
    let subSections: [Section]?

    init(title: String, content: ContentType?, subSections: [Section]?) {
        self.title = title
        self.content = content
        self.subSections = subSections
    }
}

enum ContentType {
    case local(mimeType: MimeType, value: String)
    case url(mimeType: MimeType, value: String)
}

enum MimeType: String, Codable {
    case text
    case markdown
    case html
}

// MARK: Codable

extension ContentType: Codable {

    enum Key: CodingKey {
        case type
        case mime
        case value
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let mimeType = try container.decode(MimeType.self, forKey: .mime)
        let rawValue = try container.decode(String.self, forKey: .type)
        let value = try container.decode(String.self, forKey: .value)

        switch rawValue {

            case "local":
                self = .local(mimeType: mimeType, value: value)

            case "url":
                self = .url(mimeType: mimeType, value: value)

            default:
                throw ModelCodingError.unknownValue
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        switch self {
            case .local(let mimeType, let value):
                try container.encode("local", forKey: .type)
                try container.encode(mimeType, forKey: .mime)
                try container.encode(value, forKey: .value)

            case .url(let mimeType, let value):
                try container.encode("url", forKey: .type)
                try container.encode(mimeType, forKey: .mime)
                try container.encode(value, forKey: .value)
        }
    }
}
