//
//  Copyright © 2019 An Tran. All rights reserved.
//

import UIKit

class PresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    struct Params {
        let fromCardFrame: CGRect
        let fromCell: ConferenceCollectionViewCell
    }

    private let params: Params
    private let springAnimator: UIViewPropertyAnimator
    private let presentAnimationDuration: TimeInterval

    init(params: Params) {
        self.params = params
        self.springAnimator = PresentAnimator.createBaseSpringAnimator(params: params)
        self.presentAnimationDuration = springAnimator.duration
        super.init()
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return presentAnimationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        let containerView = transitionContext.containerView

        // Assuming transition from `ConferencesCollectionViewController` to `ConferenceDetailViewController`.
        guard let listViewController = transitionContext.viewController(forKey: .from) as? ConferencesCollectionViewController,
              let detailViewController = transitionContext.viewController(forKey: .to) as? ConferenceDetailViewController,
              let detailView = detailViewController.view else {
            return
        }

        let fromCardFrame = params.fromCardFrame

        // Create a temporary `animatedContainerView` for animation.
        let animatedContainerView = UIView()
        animatedContainerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(animatedContainerView)

        // Pin centerX/width/height of the ``animatedContainerView` to the `containerView`
        let animatedContainerConstraints = [
            animatedContainerView.widthAnchor.constraint(equalToConstant: containerView.bounds.width),
            animatedContainerView.heightAnchor.constraint(equalToConstant: containerView.bounds.height),
            animatedContainerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ]
        NSLayoutConstraint.activate(animatedContainerConstraints)

        // Fix the `centerY` of the `animatedContainerView` to the center of the `containerView`.
        let animatedContainerVerticalConstraint: NSLayoutConstraint = animatedContainerView.centerYAnchor.constraint(
            equalTo: containerView.centerYAnchor,
            constant: (fromCardFrame.height/2 + fromCardFrame.minY) - containerView.bounds.height/2
        )
        animatedContainerVerticalConstraint.isActive = true

        // Add the `detailView` into the `animatedContainerView`.
        animatedContainerView.addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false

        // Pin the center of `detailView` to that of the `animatedContainerView`.
        let cardConstraints = [
            detailView.centerYAnchor.constraint(equalTo: animatedContainerView.centerYAnchor),
            detailView.centerXAnchor.constraint(equalTo: animatedContainerView.centerXAnchor),
        ]
        NSLayoutConstraint.activate(cardConstraints)

        // Pin width/height constraints of the `detailView` to that of the selected cell as the starting point for the animation.
        let cardWidthConstraint = detailView.widthAnchor.constraint(equalToConstant: fromCardFrame.width)
        let cardHeightConstraint = detailView.heightAnchor.constraint(equalToConstant: fromCardFrame.height)
        NSLayoutConstraint.activate([cardWidthConstraint, cardHeightConstraint])

        detailView.layer.cornerRadius = 10.0

        // -------------------------------
        // 0. Final preparation
        // -------------------------------
        params.fromCell.isHidden = true
        params.fromCell.resetTransform()

        containerView.layoutIfNeeded()

        // ------------------------------
        // 1. Animate container bouncing up.
        // ------------------------------
        func animateContainerBouncingUp() {
            animatedContainerVerticalConstraint.constant = 0
            containerView.layoutIfNeeded()
        }

        // ------------------------------
        // 2. Animate cardDetail filling up the container.
        // ------------------------------
        func animateCardDetailViewSizing() {
            cardWidthConstraint.constant = animatedContainerView.bounds.width
            cardHeightConstraint.constant = animatedContainerView.bounds.height
            detailView.layer.cornerRadius = 0
            containerView.layoutIfNeeded()
        }

        // ------------------------------
        // 3. Clean up.
        // ------------------------------
        func completeEverything() {
            // Remove temporary `animatedContainerView`.
            animatedContainerView.removeConstraints(animatedContainerView.constraints)
            animatedContainerView.removeFromSuperview()

            // Re-add to the top.
            containerView.addSubview(detailView)

            // Renable scrolling behaviour.
            detailViewController.collectionView.isScrollEnabled = true

            let success = !transitionContext.transitionWasCancelled
            transitionContext.completeTransition(success)
        }

        springAnimator.addAnimations { [unowned self] in

            // Spring animation for bouncing up
            animateContainerBouncingUp()

            // Linear animation for expansion
            let cardExpanding = UIViewPropertyAnimator(duration: self.presentAnimationDuration * 0.6, curve: .linear) {
                animateCardDetailViewSizing()
            }
            cardExpanding.startAnimation()
        }

        springAnimator.addCompletion { (_) in
            completeEverything()
        }

        springAnimator.startAnimation()
    }

    // MARK: Private helpers

    private static func createBaseSpringAnimator(params: PresentAnimator.Params) -> UIViewPropertyAnimator {
        // Adjust damping durtion depending on the distance of curernt frame to the top.
        let cardPositionY = params.fromCardFrame.minY
        let distanceToBounce = abs(params.fromCardFrame.minY)
        let extentToBounce = cardPositionY < 0 ? params.fromCardFrame.height : UIScreen.main.bounds.height
        let dampFactorInterval: CGFloat = 0.2
        let damping: CGFloat = 1.0 - dampFactorInterval * (distanceToBounce / extentToBounce)

        // Adjust animating durtion depending on the distance of curernt frame to the top.
        let baselineDuration: TimeInterval = 0.3
        let maxDuration: TimeInterval = 0.6
        let duration: TimeInterval = baselineDuration + (maxDuration - baselineDuration) * TimeInterval(max(0, distanceToBounce)/UIScreen.main.bounds.height)

        let springTiming = UISpringTimingParameters(dampingRatio: damping, initialVelocity: .init(dx: 0, dy: 0))
        return UIViewPropertyAnimator(duration: duration, timingParameters: springTiming)
    }
}
