//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import RxSwift
import UIKit

class VideosCollectionViewController: ViewController {
    
    // MARK: Properties

    // Static

    static var storyboardName = "Videos"

    // IBOutlets

    @IBOutlet weak var collectionView: UICollectionView!

    // Private

    private var viewModel: VideosCollectionViewModel {
        return storedViewModel as! VideosCollectionViewModel
    }

    private let disposeBag = DisposeBag()

    // MARK: Lifecycles

    override func setupViewModel() -> ViewModel! {
        return VideosCollectionViewModel(engine: context.engine)
    }

    override func setupViews() {
        super.setupViews()

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.registerNib(VideosCollectionViewCell.className, bundle: Bundle(for: VideosCollectionViewCell.self))
    }

    override func setupBindings() {
        super.setupBindings()

        viewModel.conferences.subscribe(
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

extension VideosCollectionViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

// MARK: - UICollectionViewDataSource

extension VideosCollectionViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.conferences.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideosCollectionViewCell.className, for: indexPath) as? VideosCollectionViewCell else {
            fatalError("wrong cell type")
        }

        return cell
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension VideosCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = screenSize.width - 16*2
        return CGSize(width: cellWidth, height: 200)
    }
}
