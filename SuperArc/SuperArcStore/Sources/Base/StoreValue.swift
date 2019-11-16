//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

public protocol StoreValue {
    var data: Data { get }
}

extension Data: StoreValue {
    public var data: Data {
        return self
    }
}

extension NSData: StoreValue {
    public var data: Data {
        return self as Data
    }
}

extension String: StoreValue {

    public init?(storeValue: StoreValue) {
        if let string = String(data: storeValue.data, encoding: String.Encoding.utf8) {
            self = string
        } else {
            return nil
        }
    }

    public var data: Data {
        return data(using: .utf8, allowLossyConversion: false)!
    }
}
