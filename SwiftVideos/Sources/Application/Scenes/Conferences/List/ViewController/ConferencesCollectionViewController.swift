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
            .bind(to: collectionView.rx.items(cellIdentifier: ConferenceCollectionViewCell.className)) { [weak self] _, conference, cell in
                guard let conferenceCell = cell as? ConferenceCollectionViewCell else {
                    fatalError("wrong cell type")
                }
                conferenceCell.conferenceView.titleLabel.text = conference.name
                if let bannerImage = self?.viewModel.bannerImage(for: conference) {
                    conferenceCell.conferenceView.previewImageView.image = bannerImage
                } else {
                    conferenceCell.conferenceView.previewImageView.isHidden = true
                }
            }.disposed(by: disposeBag)

        collectionView.rx.modelSelected(ConferenceMetaData.self)
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
        return UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = screenSize.width - 16*2
        return CGSize(width: cellWidth, height: 200)
    }
}
