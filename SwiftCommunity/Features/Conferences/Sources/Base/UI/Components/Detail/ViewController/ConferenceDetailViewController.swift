//
//  Copyright © 2019 An Tran. All rights reserved.
//

import CoreUX
import Core
import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import RxDataSources
import RxSwift
import UIKit

public class ConferenceDetailViewController: ViewController<ConferenceDetailViewModel>, StoryboardInitiable {

    // MARK: Properties

    // Constant

    private struct Constants {
        static let headerViewExpandedHeight: CGFloat = 150.0
        static let headerViewCollapsedHeight: CGFloat = 44 + UIApplication.shared.statusBarFrame.size.height
    }

    // Static

    public static var storyboardName = "Conferences"

    // IBOutlets

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var headerView: UIView! {
        didSet {
            headerView.addAndStretchSubView(headerVisualEffectView)
        }
    }
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!

    // Public

    public var isDismissing: Bool = false

    // Private

    private let headerVisualEffectView = UIVisualEffectView(effect: nil)

    private let blurringAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .linear)

    private var startingContentOffset: CGFloat?

    final class DismissalScreenEdgePanGesture: UIScreenEdgePanGestureRecognizer {}
    private lazy var dismissalScreenEdgePanGesture: DismissalScreenEdgePanGesture = {
        let pan = DismissalScreenEdgePanGesture()
        pan.edges = .left
        return pan
    }()

    private var interactiveStartingPoint: CGPoint?
    private var dismissalAnimator: UIViewPropertyAnimator?

    private let disposeBag = DisposeBag()

    // MARK: Lifecycles

    override public func setupViews() {
        super.setupViews()

        collectionView.delegate = self

        // Make navigationBar transparent.
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        navigationItem.setHidesBackButton(true, animated: false)

        // Prepare `collectionView`.
        // https://stackoverflow.com/questions/23786198/uicollectionview-how-can-i-remove-the-space-on-top-first-cells-row
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.contentInset.top = Constants.headerViewExpandedHeight
        collectionView.registerReusableView(ConferenceDetailSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
        collectionView.registerNib(VideosCollectionViewCell.self)

        bannerImageView.image = viewModel.conferenceViewModel.bannerImage

        // Setup blurring effect to `bannerImageView`.
        blurringAnimator.addAnimations { [weak self] in
            self?.headerVisualEffectView.effect = UIBlurEffect(style: .light)
        }
        blurringAnimator.startAnimation()
        blurringAnimator.pauseAnimation()
        blurringAnimator.pausesOnCompletion = true

        // Setup dismissal screen gesture.
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        dismissalScreenEdgePanGesture.addTarget(self, action: #selector(handleDismissalPan(gesture:)))
        dismissalScreenEdgePanGesture.delegate = self
        view.addGestureRecognizer(dismissalScreenEdgePanGesture)
    }

    override public func setupBindings() {
        super.setupBindings()

        viewModel.notification
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.notification)
            .disposed(by: disposeBag)

        viewModel.toogleStateView
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.toogleStateView)
            .disposed(by: disposeBag)

        let dataSource = RxCollectionViewSectionedReloadDataSource<ConferenceDetailSectionModel>(configureCell: { (_, collectionView, indexPath, sectionViewModel) -> UICollectionViewCell in
            switch sectionViewModel {
                case .video(let videoViewModel):
                    let videoCell = collectionView.dequeueReusableCell(VideosCollectionViewCell.self, for: indexPath)
                    videoCell.videoView.viewModel = videoViewModel
                    return videoCell
                case .authors:
                    fatalError("not supported")
            }
        })

        dataSource.configureSupplementaryView = { [weak self] (dataSource, collectionView, kind, indexPath) in
            guard kind == UICollectionView.elementKindSectionHeader else {
                fatalError("collectionView doesn't support other type of supplementary view")
            }

            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ConferenceDetailSectionHeaderView.className, for: indexPath) as! ConferenceDetailSectionHeaderView

            headerView.backgroundColor = UIColor(hex: 0xC3C3C3)
            headerView.titleLabel.text = self?.viewModel.apis.sectionTitle(for: indexPath.section)

            return headerView
        }

        viewModel.outputs.conferenceEditions
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        collectionView.rx.modelSelected(ConferenceDetailSectionDataModel.self)
            .compactMap { sectionDataModel -> VideoViewModel? in
                switch sectionDataModel {
                    case .video(let videoViewModel):
                        return videoViewModel
                    default:
                        return nil
                }
            }
            .bind(to: viewModel.inputs.didSelectVideoTrigger)
            .disposed(by: disposeBag)
    }

    override public func loadData() {
        viewModel.loadData()
    }

    deinit {
        blurringAnimator.stopAnimation(true)
    }

}

// MARK: - Interaction dismissal

extension ConferenceDetailViewController {

    private func didSuccessfullyDragDownToDismiss() {
        // Preventing interaction whild dismissing.
        isDismissing = true
        view.isUserInteractionEnabled = false
        headerVisualEffectView.removeFromSuperview()

        navigationController?.popViewController(animated: true)
    }

    private func didCancelDismissalTransition() {
        interactiveStartingPoint = nil
        dismissalAnimator = nil
    }

    @objc func handleDismissalPan(gesture: UIPanGestureRecognizer) {

        let isScreenEdgePan = gesture.isKind(of: DismissalScreenEdgePanGesture.self)
        let canStartDragDownToDismissPan = !isScreenEdgePan

        // Don't do anything when it's not in the drag down mode
        if canStartDragDownToDismissPan { return }

        let targetAnimatedView = gesture.view!
        let startingPoint: CGPoint

        if let p = interactiveStartingPoint {
            startingPoint = p
        } else {
            // Initial location
            startingPoint = gesture.location(in: nil)
            interactiveStartingPoint = startingPoint
        }

        let currentLocation = gesture.location(in: nil)
        let progress = isScreenEdgePan ? (gesture.translation(in: targetAnimatedView).x / 100) : (currentLocation.y - startingPoint.y) / 100
        let targetShrinkScale: CGFloat = 0.86
        let targetCornerRadius: CGFloat = 10.0

        func createInteractiveDismissalAnimatorIfNeeded() -> UIViewPropertyAnimator {
            if let animator = dismissalAnimator {
                return animator
            }

            let animator = UIViewPropertyAnimator(duration: 0, curve: .linear, animations: {
                targetAnimatedView.transform = .init(scaleX: targetShrinkScale, y: targetShrinkScale)
                targetAnimatedView.layer.cornerRadius = targetCornerRadius
            })
            animator.isReversed = false
            animator.pauseAnimation()
            animator.fractionComplete = progress
            return animator
        }

        switch gesture.state {
            case .began:
                dismissalAnimator = createInteractiveDismissalAnimatorIfNeeded()

            case .changed:
                dismissalAnimator = createInteractiveDismissalAnimatorIfNeeded()

                let actualProgress = progress
                let isDismissalSuccess = actualProgress >= 1.0

                dismissalAnimator!.fractionComplete = actualProgress

                if isDismissalSuccess {
                    dismissalAnimator!.stopAnimation(false)
                    dismissalAnimator!.addCompletion { [unowned self] (pos) in
                        switch pos {
                            case .end:
                                self.didSuccessfullyDragDownToDismiss()
                            default:
                                fatalError("Must finish dismissal at end!")
                        }
                    }
                    dismissalAnimator!.finishAnimation(at: .end)
            }

            case .ended, .cancelled:
                if dismissalAnimator == nil {
                    // Gesture's too quick that it doesn't have dismissalAnimator!
                    print("Too quick there's no animator!")
                    didCancelDismissalTransition()
                    return
                }

                // Ended, Animate back to start
                dismissalAnimator!.pauseAnimation()
                dismissalAnimator!.isReversed = true

                // Disable gesture until reverse closing animation finishes.
                gesture.isEnabled = false
                dismissalAnimator!.addCompletion { [unowned self] _ in
                    self.didCancelDismissalTransition()
                    gesture.isEnabled = true
                }
                dismissalAnimator!.startAnimation()

            default:
                fatalError("Impossible gesture state? \(gesture.state.rawValue)")
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ConferenceDetailViewController: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8.0, left: 16.0, bottom: 8.0, right: 16.0)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 44.0)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = screenSize.width - 16 * 2
        return CGSize(width: cellWidth, height: 310)
    }
}

// MARK: - Header Animation

extension ConferenceDetailViewController {

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {

        guard !isDismissing else {
            return
        }

        // The contentOffset is automatically adjusted when the view is shown for the first time.
        // We need to save the starting value of the contentOffset to compensate that later.
        let currentContentOffSetY = scrollView.contentOffset.y
        if startingContentOffset == nil {
            startingContentOffset = currentContentOffSetY
        }

        let contentOffSetY = currentContentOffSetY - startingContentOffset!
        let percentage: CGFloat = (contentOffSetY / (Constants.headerViewExpandedHeight - Constants.headerViewCollapsedHeight)).clamped(to: 0.0...1.0)

        if contentOffSetY > 0 {
            headerViewHeightConstraint.constant = max(Constants.headerViewCollapsedHeight, Constants.headerViewExpandedHeight - contentOffSetY)
        } else if contentOffSetY < 0 {
            if contentOffSetY < -120 {
                didSuccessfullyDragDownToDismiss()
                return
            }
            headerViewHeightConstraint.constant = Constants.headerViewExpandedHeight - contentOffSetY
        } else {
            headerViewHeightConstraint.constant = Constants.headerViewExpandedHeight
        }

        if headerViewHeightConstraint.constant == Constants.headerViewCollapsedHeight {
            title = viewModel.conferenceViewModel.name
        } else {
            title = nil
        }

        blurringAnimator.fractionComplete = percentage.clamped(to: 0.001...0.999)
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidFinishScrolling(scrollView)
    }

    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard !decelerate else {
            return
        }

        scrollViewDidFinishScrolling(scrollView)
    }

    // MARK: Private helpers

    /// Expand or collapse the header depending on the current contentOffset.y of the collectionView.
    private func scrollViewDidFinishScrolling(_ scrollView: UIScrollView) {

        guard !isDismissing else {
            return
        }

        let currentContentOffSetY = scrollView.contentOffset.y
        let contentOffSetY = abs(currentContentOffSetY - startingContentOffset!)
        let threshold = (Constants.headerViewExpandedHeight - Constants.headerViewCollapsedHeight) / 2

        if contentOffSetY > threshold && contentOffSetY < Constants.headerViewExpandedHeight - Constants.headerViewCollapsedHeight {
            animateHeaderView(scrollView, isExpanding: false)
        } else if contentOffSetY > 0 && contentOffSetY <= threshold {
            animateHeaderView(scrollView, isExpanding: true)
        }
    }

    private func animateHeaderView(_ scrollView: UIScrollView, isExpanding: Bool) {
        if isExpanding {
            scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x, y: startingContentOffset!), animated: true)
        } else {
            scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x, y: -Constants.headerViewCollapsedHeight), animated: true)
        }
    }
}

// MARK: - UIGestureRecognizerDelegate

extension ConferenceDetailViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
