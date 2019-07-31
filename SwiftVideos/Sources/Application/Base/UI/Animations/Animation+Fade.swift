//
//  Copyright © 2019 An Tran. All rights reserved.
//

import XCoordinator

extension Animation {
    static let fade = Animation(
        presentation: InteractiveTransitionAnimation.fade,
        dismissal: InteractiveTransitionAnimation.fade
    )
}

extension InteractiveTransitionAnimation {
    fileprivate static let fade = InteractiveTransitionAnimation(duration: 0.3) { transitionContext in
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!

        toView.alpha = 0.0
        containerView.addSubview(toView)

        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveLinear], animations: {
            toView.alpha = 1.0
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
