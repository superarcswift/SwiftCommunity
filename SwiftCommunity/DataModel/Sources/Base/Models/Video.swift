//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

public typealias VideoID = String

// MARK: - VideoMetaData

public typealias VideosList = [VideoMetaData]

public struct VideoMetaData: Codable {
    public let id: VideoID
    public let authors: AuthorsList
    public let conference: VideoConferenceInfo
    public let name: String
    public let source: VideoSource
}

// MARK: - VideoConferenceInfo

public struct VideoConferenceInfo: Codable {
    public let metaData: ConferenceMetaData
    public let edition: ConferenceEdition
}

// MARK: - VideoDetail

public struct VideoDetail: Codable {
    public let metaData: VideoMetaData
    public let description: String?
    public let resources: [VideoResource]?

    public init(metaData: VideoMetaData, description: String?, resources: [VideoResource]?) {
        self.metaData = metaData
        self.description = description
        self.resources = resources
    }
}

// MARK: - VideoSource

public struct VimeoResourceData: Codable {
    public let showcase: String?
    public let video: String
}

public enum VideoSource {
    case vimeo(resource: VimeoResourceData)
    case youtube(id: String)
    case wwdc(url: String)
    case website(url: String)
}

extension VideoSource: Codable {

    enum Key: CodingKey {
        case type
        case value
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let rawValue = try container.decode(String.self, forKey: .type)

        switch rawValue {

        case "vimeo":
            let resource = try container.decode(VimeoResourceData.self, forKey: .value)
            self = .vimeo(resource: resource)

        case "youtube":
            let id = try container.decode(String.self, forKey: .value)
            self = .youtube(id: id)

        case "wwdc":
            let url = try container.decode(String.self, forKey: .value)
            self = .wwdc(url: url)

        case "website":
            let url = try container.decode(String.self, forKey: .value)
            self = .website(url: url)

        default:
            throw ModelCodingError.unknownValue
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)

        switch self {

        case .vimeo(let resource):
            try container.encode("vimeo", forKey: .type)
            try container.encode(resource, forKey: .value)

        case .youtube(let id):
            try container.encode("youtube", forKey: .type)
            try container.encode(id, forKey: .value)

        case .wwdc(let url):
            try container.encode("wwdc", forKey: .type)
            try container.encode(url, forKey: .value)

        case .website(let url):
            try container.encode("website", forKey: .type)
            try container.encode(url, forKey: .value)

        }
    }
}

// MARK: - VideoResource

public enum VideoResource {
    case pdf(url: String)
    case website(url: String)
}

extension VideoResource: Codable {

    enum Key: CodingKey {
        case type
        case value
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let rawValue = try container.decode(String.self, forKey: .type)

        switch rawValue {
        case "pdf":
            let url = try container.decode(String.self, forKey: .value)
            self = .pdf(url: url)

        case "website":
            let url = try container.decode(String.self, forKey: .value)
            self = .website(url: url)

        default:
            throw ModelCodingError.unknownValue
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)

        switch self {
        case .pdf(let url):
            try container.encode("pdf", forKey: .type)
            try container.encode(url, forKey: .value)

        case .website(let url):
            try container.encode("website", forKey: .type)
            try container.encode(url, forKey: .value)

        }
    }
}
