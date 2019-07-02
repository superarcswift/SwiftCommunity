//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

extension String {
    
    func combinePath(_ component: String) -> String {
        return NSString(string: self).appendingPathComponent(component)
    }
}
