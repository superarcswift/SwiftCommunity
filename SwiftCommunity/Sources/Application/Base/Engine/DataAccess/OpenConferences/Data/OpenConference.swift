//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

/// Data model for community-driven lists of iOS Conferences available at: https://github.com/tech-conferences/conference-data/blob/master/conferences/2019/ios.json
public struct OpenConference: Decodable {
    var name: String
    var url: URL?
    var startDate: Date?
    var endDate: Date?
    var city: String?
    var country: String?
    var twitter: String?
    var cfpUrl: URL?
    var cfpEndDate: Date?

    private enum CodingKeys: String, CodingKey {
        case name
        case url
        case startDate
        case endDate
        case city
        case country
        case twitter
        case cfpUrl
        case cfpEndDate
    }

    private static var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        if let stringValue = try container.decodeIfPresent(String.self, forKey: .url) {
            url = URL(string: stringValue)
        }
        if let stringValue = try container.decodeIfPresent(String.self, forKey: .startDate) {
            startDate = OpenConference.formatter.date(from: stringValue)
        }
        if let stringValue = try container.decodeIfPresent(String.self, forKey: .endDate) {
            endDate = OpenConference.formatter.date(from: stringValue)
        }
        city = try container.decode(String.self, forKey: .city)
        country = try container.decode(String.self, forKey: .country)
        twitter = try container.decodeIfPresent(String.self, forKey: .twitter)
        if let stringValue = try container.decodeIfPresent(String.self, forKey: .cfpUrl) {
            cfpUrl = URL(string: stringValue)
        }
        if let stringValue = try container.decodeIfPresent(String.self, forKey: .cfpEndDate) {
            cfpEndDate = OpenConference.formatter.date(from: stringValue)
        }
    }
}

//struct OpenConference: Decodable {
//    let name: String?
//    @CodableURL var url: URL?
//    @CodableDateYMD var startDate: Date?
//    @CodableDateYMD var endDate: Date?
//    let city: String?
//    let country: String?
//    let twitter: String?
//    @CodableURL var cfpUrl: URL?
//    @CodableDateYMD var cfpEndDate: Date?
//}
//
//@propertyWrapper
//struct CodableDateYMD {
//    var wrappedValue: Date?
//
//    private static var formatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        return formatter
//    }()
//}
//
//extension CodableDateYMD: Decodable {
//    init(from decoder: Decoder) throws {
//        if let stringValue = try? String(from: decoder) {
//            wrappedValue = CodableDateYMD.formatter.date(from: stringValue)
//        }
//    }
//}
//
//@propertyWrapper
//struct CodableURL {
//    var wrappedValue: URL?
//}
//
//extension CodableURL: Decodable {
//    init(from decoder: Decoder) throws {
//        if let stringValue = try? String(from: decoder) {
//            wrappedValue = URL(string: stringValue)
//        }
//    }
//}
