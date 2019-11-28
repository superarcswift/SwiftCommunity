//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import SuperArcActivityIndicator
import SuperArcLocalization
import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import RxSwift
import UIKit

public class ConferencesCollectionViewController: ViewController<ConferencesCollectionViewModel>, StoryboardInitiable {

    // MARK: Properties

    // Static

    public static var storyboardName = "Conferences"

    // IBOutlets

    @IBOutlet weak var collectionView: UICollectionView!

    // Public

    var builder: UnownedWrapper<ConferencesComponent>?

    // Private

    private var transition: ConferenceTransition?

    private let disposeBag = DisposeBag()

    // MARK: Lifecycles

    override public func setupViews() {
        super.setupViews()

        navigationItem.largeTitleDisplayMode = .always

        collectionView.delegate = self

        collectionView.registerNib(ConferenceCollectionViewCell.self)

        titleKey = "conferences"

        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

    override public func setupBindings() {
        super.setupBindings()

        viewModel.notification
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.notification)
            .disposed(by: disposeBag)

        viewModel.toggleEmptyState
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.toogleStateView)
            .disposed(by: disposeBag)

        viewModel.outputs.conferences
            .bind(to: collectionView.rx.items(cellIdentifier: ConferenceCollectionViewCell.className)) { _, conferenceViewModel, cell in
                guard let conferenceCell = cell as? ConferenceCollectionViewCell else {
                    fatalError("wrong cell type")
                }
                conferenceCell.conferenceView.viewModel = conferenceViewModel
            }.disposed(by: disposeBag)

//        collectionView.rx.modelSelected(ConferenceViewModel.self)
//            .bind(to: viewModel.inputs.didSelectConferenceTrigger)
//            .disposed(by: disposeBag)
    }

    override public func loadData() {
        viewModel.apis.loadData()
    }
}

// MARK: - UICollectionViewDelegate

extension ConferencesCollectionViewController: UICollectionViewDelegate {

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        // Get tapped cell location
        let cell = collectionView.cellForItem(at: indexPath) as! ConferenceCollectionViewCell

        // Get current frame on screen
        let currentCellFrame = cell.layer.presentation()!.frame

        // Convert current frame to screen's coordinates
        let cardPresentationFrameOnScreen = cell.superview!.convert(currentCellFrame, to: nil)

        // Get card frame without transform in screen's coordinates  (for the dismissing back later to original location)
        let cardFrameWithoutTransform = { () -> CGRect in
            let center = cell.center
            let size = cell.bounds.size
            let r = CGRect(
                x: center.x - size.width / 2,
                y: center.y - size.height / 2,
                width: size.width,
                height: size.height
            )
            return cell.superview!.convert(r, to: nil)
        }()

        let conferenceMetaData = viewModel.conferences.value[indexPath.row].conferenceMetaData
        let detailViewController = builder!.wrappedValue.makeConferenceDetailViewController(conferenceMetaData: conferenceMetaData, router: viewModel.router)

        let params = ConferenceTransition.Params(fromCardFrame: cardPresentationFrameOnScreen,
                                           fromCardFrameWithoutTransform: cardFrameWithoutTransform,
                                           fromCell: cell)

        transition = ConferenceTransition(params: params)
        detailViewController.transitioningDelegate = transition

        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ConferencesCollectionViewController: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = screenSize.width - 16*2
        return CGSize(width: cellWidth, height: 150)
    }
}

//extension ConferencesCollectionViewController: UIViewControllerTransitioningDelegate {
//
//    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//
//        return FadePushAnimator()
//        guard let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first,
//              let selectedCell = collectionView.cellForItem(at: selectedIndexPath) as? ConferenceCollectionViewCell,
//              let selectedCellSuperView = selectedCell.superview else {
//            return nil
//        }
//
//        // Freeze highlighted state (or else it will bounce back)
//        selectedCell.freezeAnimations()
//
//        // Get current frame on screen
//        let currentCellFrame = selectedCell.layer.presentation()!.frame
//
//        // Convert current frame to screen's coordinates
//        let cardPresentationFrameOnScreen = selectedCellSuperView.convert(currentCellFrame, to: nil)
//
//        // Get card frame without transform in screen's coordinates  (for the dismissing back later to original location)
//        let cardFrameWithoutTransform = { () -> CGRect in
//            let center = selectedCell.center
//            let size = selectedCell.bounds.size
//            let r = CGRect(
//                x: center.x - size.width / 2,
//                y: center.y - size.height / 2,
//                width: size.width,
//                height: size.height
//            )
//            return selectedCellSuperView.convert(r, to: nil)
//        }()
//
//        let params = CardTransition.Params(fromCardFrame: cardPresentationFrameOnScreen,
//                                           fromCardFrameWithoutTransform: cardFrameWithoutTransform,
//                                           fromCell: selectedCell)
//        transition = CardTransition(params: params)
//
//        return nil
//    }

//    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        transition.presenting = false
//        return transition
//    }

//}
