//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

public protocol ServiceContextProtocol {
    var realm: String { get }
    
}

public class ServiceContext: ServiceContextProtocol {

    public let realm: String

    public init(realm: String) {
        self.realm = realm
    }
}
