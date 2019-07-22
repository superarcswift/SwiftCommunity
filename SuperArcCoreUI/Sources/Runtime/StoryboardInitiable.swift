//
//  Copyright © 2019 An Tran. All rights reserved.
//

import UIKit

public protocol StoryboardInitiable: class {
    static var storyboardName: String { get }
    static func instantiate() -> Self
}

extension StoryboardInitiable {
    public static func instantiate() -> Self {
        let identifier = String(describing: Self.self)
        return UIStoryboard(name: storyboardName, bundle: Bundle(for: Self.self)).instantiateViewController(withIdentifier: identifier) as! Self
    }
}
