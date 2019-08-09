//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCoreUI

/// Protocol defining dependencies for a viewModel.
protocol DependencyInjectedViewModelProtocol where Self: ViewModel {
    associatedtype DependencyType: Dependency

    var dependency: DependencyType { get }
}
