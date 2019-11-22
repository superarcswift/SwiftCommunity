//
//  Copyright © 2019 An Tran. All rights reserved.
//

public struct Endpoint: RawRepresentable {
    public var rawValue: String

    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }

    public init?(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension Endpoint {
    public static let production = Endpoint("production")
    public static let staging = Endpoint("staging")
    public static let development = Endpoint("development")
}
