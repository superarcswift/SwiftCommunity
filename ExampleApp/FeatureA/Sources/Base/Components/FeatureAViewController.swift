//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore

class FeatureAViewController: ViewController<ViewModel>, ViewControllerRoutable, StoryboardInitiable {

    // MARK: Properties

    // Static

    static var storyboardName = "FeatureA"

    // Private

    lazy var componentsRouter: AnyComponentRouter<FeatureAComponentRoute> = {
        return (storedComponentsRouter as! HasFeatureAComponentRouter).featureARouter
    }()

    // MARK: IBActions

    @IBAction func didTapFeatureB(_ sender: Any) {
        // TODO: see if we can remove this force cast. This componentsRouter needs to be injected
        print("should go to feature B from feature A")
        let presentable = componentsRouter.trigger(.featureB)
        present(presentable.viewController, animated: true)
    }

    @IBAction func didTapFeatureC(_ sender: Any) {
        print("should go to feature C from feature A")
        let presentable = componentsRouter.trigger(.featureC)
        present(presentable.viewController, animated: true)
    }

    @IBAction func didTapFeatureD(_ sender: Any) {
        print("should go to feature D from feature A")
        let presentable = componentsRouter.trigger(.featureD)
        navigationController?.pushViewController(presentable.viewController, animated: true)
    }
}
