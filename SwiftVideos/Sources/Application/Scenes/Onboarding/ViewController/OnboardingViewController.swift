//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import RxSwift

class OnboardingViewController: ViewController<OnboardingViewModel>, StoryboardInitiable {

    // MARK: Properties

    // Static

    static var storyboardName = "Onboarding"

    // Private

    private let disposeBag = DisposeBag()

    // MARK: Overrides

    override func loadData() {
        viewModel.apis.prepareLocalRepository()
    }

    // MARK: IBActions

    @IBAction func didTapCloneButton(_ sender: Any) {
        loadData()
    }
}
