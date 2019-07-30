//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import RxSwift
import UIKit

class AuthorsCollectionViewController: ViewController, StoryboardInitiable {

    // MARK: Properties

    // Static

    static var storyboardName = "Authors"

    // IBOutlets

    @IBOutlet weak var collectionView: UICollectionView!

    // Public

    var viewModel: AuthorsCollectionViewModel {
        return storedViewModel as! AuthorsCollectionViewModel
    }

    private let disposeBag = DisposeBag()

    // MARK: Lifecycles

    override func setupViews() {
        super.setupViews()

        collectionView.delegate = self

        collectionView.registerNib(AuthorsCollectionViewCell.className, bundle: Bundle(for: AuthorsCollectionViewCell.self))
    }

    override func setupBindings() {
        super.setupBindings()

        viewModel.authors
            .bind(to: collectionView.rx.items(cellIdentifier: AuthorsCollectionViewCell.className)) { _, element, cell in

            }.disposed(by: disposeBag)

        collectionView.rx.modelSelected(AuthorMetaData.self)
            .bind(to: viewModel.didSelectAuthor)
            .disposed(by: disposeBag)
    }

    override func loadData() {
        viewModel.loadData()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension AuthorsCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = (screenSize.width - 16*2 - 16*2) / 2
        return CGSize(width: cellWidth, height: 150)
    }
}
