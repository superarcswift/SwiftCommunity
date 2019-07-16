//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

open class Model<T:Codable>: Codable {

    // MARK: Properties

    open var updateTimestamp: TimeInterval = 0

    public var data: T? = nil

    public enum CodingKeys: String, CodingKey {
        case updateTimestamp
        case data
    }

    // MARK: Intialization

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        updateTimestamp = try container.decode(TimeInterval.self, forKey: .updateTimestamp)
        data = try container.decode(T.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(updateTimestamp, forKey: .updateTimestamp)
        try container.encode(data, forKey: .data)
    }
}
