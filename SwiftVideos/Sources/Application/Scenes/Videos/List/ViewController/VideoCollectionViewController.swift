//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import RxSwift
import UIKit

class VideosCollectionViewController: ViewController<VideosCollectionViewModel>, StoryboardInitiable {
    
    // MARK: Properties

    // Static

    static var storyboardName = "Videos"

    // IBOutlets

    @IBOutlet weak var collectionView: UICollectionView!

    // Public

    private let disposeBag = DisposeBag()

    // MARK: Lifecycles

    override func setupViews() {
        super.setupViews()

        collectionView.delegate = self

        collectionView.registerNib(VideosCollectionViewCell.className, bundle: Bundle(for: VideosCollectionViewCell.self))

        title = viewModel.outputs.title
    }

    override func setupBindings() {
        super.setupBindings()

        viewModel.notification
            .bind(to: self.rx.notification)
            .disposed(by: disposeBag)

        viewModel.toogleStateView
            .bind(to: self.rx.toogleStateView)
            .disposed(by: disposeBag)

        viewModel.outputs.videos
            .bind(to: collectionView.rx.items(cellIdentifier: VideosCollectionViewCell.className)) { [weak self] _, video, cell in
                guard let videoCell = cell as? VideosCollectionViewCell else {
                    fatalError("invalid cell type")
                }

                videoCell.videoView.titleLabel.text = video.name

                videoCell.videoView.authorNameLabel.text = video.authors.first?.name

                if let previewImage = self?.viewModel.apis.previewImage(for: video) {
                    videoCell.videoView.previewImageView.image = previewImage
                } else {
                    videoCell.videoView.previewImageView.isHidden = true
                }

            }.disposed(by: disposeBag)

        collectionView.rx.modelSelected(VideoMetaData.self)
            .bind(to: viewModel.inputs.didSelectVideoTrigger)
            .disposed(by: disposeBag)
    }

    override func loadData() {
        viewModel.loadData()
    }

    // MARK: Actions

    @objc override func close() {
        viewModel.close()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension VideosCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = screenSize.width - 16*2
        return CGSize(width: cellWidth, height: 280)
    }
}
