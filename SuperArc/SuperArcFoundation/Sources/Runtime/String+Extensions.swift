//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

extension String {

    public func combinePath(_ component: String) -> String {
        return NSString(string: self).appendingPathComponent(component)
    }

    public var urlComponents: URLComponents {
        return URLComponents(string: self)!
    }

    public var basePath: String {
        return (self as NSString).deletingLastPathComponent
    }
}
