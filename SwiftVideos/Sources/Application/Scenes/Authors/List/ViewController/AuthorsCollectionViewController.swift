//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import RxSwift
import UIKit

class AuthorsCollectionViewController: ViewController<AuthorsCollectionViewModel>, StoryboardInitiable {

    // MARK: Properties

    // Static

    static var storyboardName = "Authors"

    // IBOutlets

    @IBOutlet weak var collectionView: UICollectionView!

    private let disposeBag = DisposeBag()

    // MARK: Lifecycles

    override func setupViews() {
        super.setupViews()

        collectionView.delegate = self

        collectionView.registerNib(AuthorsCollectionViewCell.className, bundle: Bundle(for: AuthorsCollectionViewCell.self))
    }

    override func setupBindings() {
        super.setupBindings()

        viewModel.outputs.authors
            .bind(to: collectionView.rx.items(cellIdentifier: AuthorsCollectionViewCell.className)) { _, authorViewModel, cell in

                guard let authorCell = cell as? AuthorsCollectionViewCell else {
                    fatalError("invalid cell type")
                }

                authorCell.authorView.nameLabel.text = authorViewModel.name
                authorCell.authorView.avatarImageView.image = authorViewModel.avatarImage
            }.disposed(by: disposeBag)

        collectionView.rx.modelSelected(AuthorViewModel.self)
            .bind(to: viewModel.inputs.didSelectAuthor)
            .disposed(by: disposeBag)
    }

    override func loadData() {
        viewModel.apis.loadData()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension AuthorsCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 170)
    }
}
