//
//  Copyright © 2019 An Tran. All rights reserved.
//

public protocol ClassNameDerivable: class {
    var className: String { get }
}

extension ClassNameDerivable {
    public var className: String {
        return String(describing: self)
    }
}
