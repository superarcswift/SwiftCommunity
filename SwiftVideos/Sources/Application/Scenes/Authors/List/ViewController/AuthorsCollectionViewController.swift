//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import RxSwift
import UIKit

class AuthorsCollectionViewController: ViewController {

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

    override func setupViewModel() -> ViewModel! {
        return AuthorsCollectionViewModel(engine: context.engine)
    }

    override func setupViews() {
        super.setupViews()

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.registerNib(AuthorsCollectionViewCell.className, bundle: Bundle(for: AuthorsCollectionViewCell.self))
    }

    override func setupBindings() {
        super.setupBindings()

        viewModel.authors.subscribe(
            onNext: { conferences in
                self.collectionView.reloadData()
        }
            ).disposed(by: disposeBag)
    }

    override func loadData() {
        viewModel.loadData()
    }
}

// MARK: - UICollectionViewDelegate

extension AuthorsCollectionViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectAt(indexPath.row)
    }
}

// MARK: - UICollectionViewDataSource

extension AuthorsCollectionViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.authors.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AuthorsCollectionViewCell.className, for: indexPath) as? AuthorsCollectionViewCell else {
            fatalError("wrong cell type")
        }

        return cell
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
