//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import RxSwift
import UIKit

class ConferencesCollectionViewController: ViewController, StoryboardInitiable {

    // MARK: Properties

    // Static

    static var storyboardName = "Conferences"

    // IBOutlets

    @IBOutlet weak var collectionView: UICollectionView!

    // Public

    var viewModel: ConferencesCollectionViewModel {
        return storedViewModel as! ConferencesCollectionViewModel
    }

    // Private

    private let disposeBag = DisposeBag()

    // MARK: Lifecycles

    override func setupViews() {
        super.setupViews()

        collectionView.delegate = self

        collectionView.registerNib(ConferenceCollectionViewCell.className, bundle: Bundle(for: ConferenceCollectionViewCell.self))
    }

    override func setupBindings() {
        super.setupBindings()

        viewModel.conferences
            .bind(to: collectionView.rx.items(cellIdentifier: ConferenceCollectionViewCell.className)) { _, element, cell in

            }.disposed(by: disposeBag)

        collectionView.rx.modelSelected(Conference.self)
            .bind(to: viewModel.didSelectConferenceTrigger)
            .disposed(by: disposeBag)
    }

    override func loadData() {
        viewModel.loadData()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ConferencesCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = screenSize.width - 16*2
        return CGSize(width: cellWidth, height: 200)
    }
}
