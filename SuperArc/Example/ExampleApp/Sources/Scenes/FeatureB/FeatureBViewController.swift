//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore

class FeatureBViewController: TableViewController<ViewModel>, StoryboardInitiable {

    // MARK: Properties

    // Static

    static var storyboardName = "FeatureB"

    lazy var componentsRouter: ComponentsRouter = {
        self.viewControllerContext.resolve(type: ComponentsRouter.self)
    }()

    // MARK: Overriden

    override func setupViews() {
        super.setupViews()

        tableView.tableFooterView = UIView(frame: .zero)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("should go to feature A from feature B")
            let presentable = componentsRouter.featureAInterface.show(dependency: componentsRouter, hasRightCloseButton: true)
            present(presentable.viewController, animated: true)

        case 1:
            print("should go to feature C from feature B")
            let presentable = componentsRouter.featureCInterface.show(dependency: componentsRouter, hasRightCloseButton: true)
            present(presentable.viewController, animated: true)

        case 2:
            print("should go to feature D from feature B")
            let presentable = componentsRouter.featureDInterface.show(dependency: componentsRouter)
            navigationController?.pushViewController(presentable.viewController, animated: true)

        default:
            fatalError()
        }
    }
}
