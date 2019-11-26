//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore

class FeatureAViewController: ViewController<ViewModel>, StoryboardInitiable {

    // MARK: Properties

    // Static

    static var storyboardName = "FeatureA"

    lazy var navigator: Navigator = {
        self.viewControllerContext.resolve(type: Navigator.self)
    }()

    // MARK: IBActions

    @IBAction func didTapFeatureB(_ sender: Any) {
        print("should go to feature B from feature A")
        let presentable = navigator.featureBInterface.show(dependency: navigator, hasRightCloseButton: true)
        present(presentable.viewController, animated: true)
    }

    @IBAction func didTapFeatureC(_ sender: Any) {
        print("should go to feature C from feature A")
        let presentable = navigator.featureCInterface.show(dependency: navigator, hasRightCloseButton: true)
        present(presentable.viewController, animated: true)
    }

    @IBAction func didTapFeatureD(_ sender: Any) {
        print("should go to feature D from feature A")
        let presentable = navigator.featureDInterface.show(dependency: navigator)
        navigationController?.pushViewController(presentable.viewController, animated: true)
    }
}
