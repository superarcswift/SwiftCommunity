//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import RxSwift
import UIKit

class ConferenceDetailViewController: ViewController<ConferenceDetailViewModel>, StoryboardInitiable {

    // MARK: Properties

    // Static

    public static var storyboardName = "Conferences"

    // IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!

    // Private

    private let disposeBag = DisposeBag()

    // MARK: Lifecycles

    override func setupViews() {
        super.setupViews()

        collectionView.delegate = self

        collectionView.registerNib(ConferenceDetailEditionCollectionViewCell.className, bundle: Bundle(for: ConferenceDetailEditionCollectionViewCell.self))

        title = viewModel.conferenceMetaData.name
    }

    override func setupBindings() {
        super.setupBindings()

        viewModel.notification
            .bind(to: self.rx.notification)
            .disposed(by: disposeBag)

        viewModel.conferenceEditions
            .bind(to: collectionView.rx.items(cellIdentifier: ConferenceDetailEditionCollectionViewCell.className)) { _, conferenceEdition, cell in
                guard let cell = cell as? ConferenceDetailEditionCollectionViewCell else {
                    fatalError("wrong cell type")
                }

                // TODO: create a asString extension for Int
                cell.nameLabel.text = "\(conferenceEdition.year)"
                cell.backgroundColor = .green

            }.disposed(by: disposeBag)

        collectionView.rx.modelSelected(ConferenceEdition.self)
            .bind(to: viewModel.didSelectConferenceEditionTrigger)
            .disposed(by: disposeBag)
    }

    override public func loadData() {
        viewModel.loadData()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ConferenceDetailViewController: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = screenSize.width - 16*2
        return CGSize(width: cellWidth, height: 100)
    }
}
