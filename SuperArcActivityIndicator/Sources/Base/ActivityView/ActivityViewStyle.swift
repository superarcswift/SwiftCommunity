//
//  Copyright © 2019 An Tran. All rights reserved.
//

import UIKit

public struct ActivityViewStyle {
    public let backdropColor: UIColor
    public let backgroundColor: UIColor
    public let spinnerColor: UIColor
}

extension ActivityViewStyle {
    public static let standard = ActivityViewStyle(backdropColor: UIColor.black.withAlphaComponent(0.1), backgroundColor: UIColor.black.withAlphaComponent(0.5), spinnerColor: .white)
}
