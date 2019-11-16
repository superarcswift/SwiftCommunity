//
//  Copyright © 2019 An Tran. All rights reserved.
//

extension Dictionary {
    public mutating func merge(with dict: [Key: Value]) {
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}

public func + <K, V>(lhs: [K: V], rhs: [K: V]) -> [K: V] {
    var combined = lhs
    for (k, v) in rhs {
        combined[k] = v
    }
    return combined
}
