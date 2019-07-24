//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import RxSwift
import UIKit

class VideosCollectionViewController: ViewController, StoryboardInitiable {
    
    // MARK: Properties

    // Static

    static var storyboardName = "Videos"

    // IBOutlets

    @IBOutlet weak var collectionView: UICollectionView!

    // Private

    var viewModel: VideosCollectionViewModel {
        return storedViewModel as! VideosCollectionViewModel
    }

    private let disposeBag = DisposeBag()

    // MARK: Lifecycles

    override func setupViews() {
        super.setupViews()

        collectionView.delegate = self

        collectionView.registerNib(VideosCollectionViewCell.className, bundle: Bundle(for: VideosCollectionViewCell.self))
    }

    override func setupBindings() {
        super.setupBindings()

        viewModel.videos
            .bind(to: collectionView.rx.items(cellIdentifier: VideosCollectionViewCell.className)) { _, element, cell in

            }.disposed(by: disposeBag)

        collectionView.rx.modelSelected(Video.self)
            .bind(to: viewModel.didSelectVideo)
            .disposed(by: disposeBag)
    }

    override func loadData() {
        viewModel.loadData()
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
