//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcActivityIndicator
import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import RxSwift
import UIKit

class ConferencesCollectionViewController: ViewController<ConferencesCollectionViewModel>, StoryboardInitiable {

    // MARK: Properties

    // Static

    static var storyboardName = "Conferences"

    // IBOutlets

    @IBOutlet weak var collectionView: UICollectionView!

    // Private

    private let disposeBag = DisposeBag()

    // MARK: Lifecycles

    override public func setupViews() {
        super.setupViews()

        collectionView.delegate = self

        collectionView.registerNib(ConferenceCollectionViewCell.self)
    }

    override func setupBindings() {
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
            .bind(to: collectionView.rx.items(cellIdentifier: ConferenceCollectionViewCell.className)) { [weak self] _, conference, cell in
                guard let conferenceCell = cell as? ConferenceCollectionViewCell else {
                    fatalError("wrong cell type")
                }
                conferenceCell.conferenceView.titleLabel.text = conference.name
                if let bannerImage = self?.viewModel.apis.bannerImage(for: conference) {
                    conferenceCell.conferenceView.previewImageView.image = bannerImage
                } else {
                    conferenceCell.conferenceView.previewImageView.isHidden = true
                }
            }.disposed(by: disposeBag)

        collectionView.rx.modelSelected(ConferenceMetaData.self)
            .bind(to: viewModel.inputs.didSelectConferenceTrigger)
            .disposed(by: disposeBag)
    }

    override func loadData() {
        viewModel.apis.loadData()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ConferencesCollectionViewController: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = screenSize.width - 16*2
        return CGSize(width: cellWidth, height: 200)
    }
}
