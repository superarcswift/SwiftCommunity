//
//  Copyright © 2019 An Tran. All rights reserved.
//

import DataModels

class Section: Codable {
    let id: String
    let title: String
    let content: Content?
    let sections: [Section]?

    init(id: String, title: String, content: Content?, sections: [Section]?) {
        self.id = id
        self.title = title
        self.content = content
        self.sections = sections
    }
}

enum Content {
    case local(mimeType: Mime, value: String)
    case url(mimeType: Mime, value: String)
}

enum Mime: String, Codable {
    case text
    case markdown
    case html
}

// MARK: Codable

extension Content: Codable {

    enum Key: CodingKey {
        case type
        case mime
        case value
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let mimeType = try container.decode(Mime.self, forKey: .mime)
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

// MARK: Tree operaton

extension Section {

    func search(for sectionID: String) -> Section? {
        if sectionID == self.id {
            return self
        }

        guard let sections = sections else {
            return nil
        }

        for section in sections {
            if let found = section.search(for: sectionID) {
                return found
            }
        }

        return nil
    }
}
