//
//___COPYRIGHT___
//

import SuperArcNotificationBanner
import SuperArcStateView
import SuperArcCoreUI
import SuperArcCore
import XCoordinator
import Action
import RxSwift
import RxCocoa

protocol ___FILEBASENAMEASIDENTIFIER___Input {
}

protocol ___FILEBASENAMEASIDENTIFIER___Output {
}

protocol ___FILEBASENAMEASIDENTIFIER___Api {
}

protocol ___FILEBASENAMEASIDENTIFIER___Type {
    var inputs: ___FILEBASENAMEASIDENTIFIER___Input { get }
    var outputs: ___FILEBASENAMEASIDENTIFIER___Output { get }
    var apis: ___FILEBASENAMEASIDENTIFIER___Api { get }
}

extension ___FILEBASENAMEASIDENTIFIER___Type where Self: ___FILEBASENAMEASIDENTIFIER___Input & ___FILEBASENAMEASIDENTIFIER___Output & ___FILEBASENAMEASIDENTIFIER___Api {

    var inputs: ___FILEBASENAMEASIDENTIFIER___Input {
        return self
    }

    var outputs: ___FILEBASENAMEASIDENTIFIER___Output {
        return self
    }

    var apis: ___FILEBASENAMEASIDENTIFIER___Api {
        return self
    }
}

class ___FILEBASENAMEASIDENTIFIER___: ViewModel {

    // MARK: Propeties

    // Public

    // Private

    // MARK: APIs

    // MARK: Private helpers
}
