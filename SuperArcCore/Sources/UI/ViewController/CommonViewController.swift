//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

public protocol CommonViewController: HasViewControllerContext {

    var storedViewModel: ViewModel? { get set }
}
