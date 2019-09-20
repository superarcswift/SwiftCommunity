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

    lazy var componentsRouter: ComponentsRouter = {
        // TODO: See if we can remove this force cast
        self.viewControllerContext.resolve(type: ComponentsRouter.self)
    }()

    // MARK: IBActions

    @IBAction func didTapFeatureB(_ sender: Any) {
        print("should go to feature B from feature A")
        let presentable = componentsRouter.featureBInterface.show(dependency: componentsRouter, hasRightCloseButton: true)
        present(presentable.viewController, animated: true)
    }

    @IBAction func didTapFeatureC(_ sender: Any) {
        print("should go to feature C from feature A")
        let presentable = componentsRouter.featureCInterface.show(dependency: componentsRouter, hasRightCloseButton: true)
        present(presentable.viewController, animated: true)
    }

    @IBAction func didTapFeatureD(_ sender: Any) {
        print("should go to feature D from feature A")
        let presentable = componentsRouter.featureDInterface.show(dependency: componentsRouter)
        navigationController?.pushViewController(presentable.viewController, animated: true)
    }
}
