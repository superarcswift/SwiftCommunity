//
//  Copyright © 2019 An Tran. All rights reserved.
//

public protocol ClassNameDerivable: class {
    var name: String { get }
}

extension ClassNameDerivable {
    public var name: String {
        return "\(Self.self)"
    }
}
