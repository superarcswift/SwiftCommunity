//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore

class FeatureAViewController: ViewController<ViewModel>, StoryboardInitiable {

    static var storyboardName = "FeatureA"

    // MARK: IBActions

    @IBAction func didTapFeatureB(_ sender: Any) {
        // TODO: see if we can remove this force cast
        let presentable = (componentsRouter as! ComponentsRouter).featureARouter.trigger(.featureB)
        present(presentable.viewController, animated: true)
    }

    @IBAction func didTapFeatureC(_ sender: Any) {
        let presentable = (componentsRouter as! ComponentsRouter).featureARouter.trigger(.featureC)
        present(presentable.viewController, animated: true)
    }

    @IBAction func didTapFeatureD(_ sender: Any) {
        let presentable = (componentsRouter as! ComponentsRouter).featureARouter.trigger(.featureD)
        navigationController?.pushViewController(presentable.viewController, animated: true)
    }
}
