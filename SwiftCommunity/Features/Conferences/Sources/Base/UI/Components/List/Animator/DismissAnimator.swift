//
//  Copyright © 2019 An Tran. All rights reserved.
//

import UIKit

class DismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    struct Params {
        let fromCardFrame: CGRect
        let fromCardFrameWithoutTransform: CGRect
        let fromCell: ConferenceCollectionViewCell
    }

    struct Constants {
        static let relativeDurationBeforeNonInteractive: TimeInterval = 0.5
        static let minimumScaleBeforeNonInteractive: CGFloat = 0.8
    }

    private let params: Params

    init(params: Params) {
        self.params = params
        super.init()
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        let containerView = transitionContext.containerView

        // Assuming transition from `ConferenceDetailViewController` to `ConferencesCollectionViewController`.
        guard let listViewController = transitionContext.viewController(forKey: .to) as? ConferencesCollectionViewController,
            let detailViewController = transitionContext.viewController(forKey: .from) as? ConferenceDetailViewController,
            let listView = listViewController.view,
            let detailView = detailViewController.view else {
                return
        }

        // Disable blurring header in `detailViewController`.
        detailViewController.isDismissing = true

        containerView.addSubview(listView)

        // Create a temporary `animatedContainerView` for animation.
        let animatedContainerView = UIView()
        animatedContainerView.translatesAutoresizingMaskIntoConstraints = false

        // Wire up the views: `detailView` -> `animatedContainerView` -> `containerView`
        containerView.addSubview(animatedContainerView)
        animatedContainerView.addSubview(detailView)

        // Card fills inside the animatedContainerView`.
        detailView.stretch(to: animatedContainerView)

        animatedContainerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        let animatedContainerTopConstraint = animatedContainerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0)
        let animatedContainerWidthConstraint = animatedContainerView.widthAnchor.constraint(equalToConstant: detailView.frame.width)
        let animatedContainerHeightConstraint = animatedContainerView.heightAnchor.constraint(equalToConstant: detailView.frame.height)

        NSLayoutConstraint.activate([animatedContainerTopConstraint, animatedContainerWidthConstraint, animatedContainerHeightConstraint])

        containerView.layoutIfNeeded()

        // Force card filling bottom
        let stretchCardToFillBottom = detailViewController.bannerImageView.bottomAnchor.constraint(equalTo: detailView.bottomAnchor)

        func animateCardViewBackToPlace() {

            stretchCardToFillBottom.isActive = true
            // Back to identity
            // NOTE: Animated container view in a way, helps us to not messing up `transform` with `AutoLayout` animation.
            detailView.transform = CGAffineTransform.identity
            animatedContainerTopConstraint.constant = self.params.fromCardFrameWithoutTransform.minY
            animatedContainerWidthConstraint.constant = self.params.fromCardFrameWithoutTransform.width
            animatedContainerHeightConstraint.constant = self.params.fromCardFrameWithoutTransform.height

            detailView.cornerRadius = 10.0
            detailView.clipsToBounds = true

            containerView.layoutIfNeeded()
        }

        func completeEverything() {
            let success = !transitionContext.transitionWasCancelled
            animatedContainerView.removeConstraints(animatedContainerView.constraints)
            animatedContainerView.removeFromSuperview()
            if success {
                detailView.removeFromSuperview()
                self.params.fromCell.isHidden = false
            } else {

                // Restore scrolling behaviour in `detailViewController`
                detailViewController.isDismissing = false

                // Remove temporary fixes if not success!
                stretchCardToFillBottom.isActive = false

                detailView.removeConstraint(stretchCardToFillBottom)
                containerView.removeConstraints(containerView.constraints)

                containerView.addSubview(detailView)
                listView.removeFromSuperview()

                detailView.stretch(to: containerView)
            }
            transitionContext.completeTransition(success)
        }

        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: {
            animateCardViewBackToPlace()
        }) { _ in
            completeEverything()
        }

        UIView.animate(withDuration: transitionDuration(using: transitionContext) * 0.6) {
            detailViewController.collectionView.setContentOffset(.zero, animated: false)
        }
    }
}
