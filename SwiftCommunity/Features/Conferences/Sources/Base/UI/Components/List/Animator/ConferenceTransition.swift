//
//  Copyright © 2019 An Tran. All rights reserved.
//

import UIKit

final class ConferenceTransition: NSObject, UIViewControllerTransitioningDelegate {

    struct Params {
        let fromCardFrame: CGRect
        let fromCardFrameWithoutTransform: CGRect
        let fromCell: ConferenceCollectionViewCell
    }

    let params: Params

    init(params: Params) {
        self.params = params
        super.init()
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let params = PresentAnimator.Params(
            fromCardFrame: self.params.fromCardFrame,
            fromCell: self.params.fromCell
        )

        return PresentAnimator(params: params)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let params = DismissAnimator.Params(
            fromCardFrame: self.params.fromCardFrame,
            fromCardFrameWithoutTransform: self.params.fromCardFrameWithoutTransform,
            fromCell: self.params.fromCell
        )
        return DismissAnimator(params: params)
    }
}
