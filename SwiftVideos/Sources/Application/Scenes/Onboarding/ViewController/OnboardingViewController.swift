//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import RxSwift

class OnboardingViewController: ViewController, StoryboardInitiable {

    // MARK: Properties

    // Static

    static var storyboardName = "Onboarding"

    // Public

    var viewModel: OnboardingViewModel {
        return storedViewModel as! OnboardingViewModel
    }

    // Private

    let disposeBag = DisposeBag()

    // MARK: Overrides

    override func loadData() {
        viewModel.prepareLocalRepository()
    }
}
