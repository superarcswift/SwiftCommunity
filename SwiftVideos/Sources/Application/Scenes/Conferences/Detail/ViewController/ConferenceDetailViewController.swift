//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import RxDataSources
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

        // TODO: create an UICollectionView extension for this
        let sectionHeader = UINib(nibName: ConferenceDetailSectionHeaderView.className, bundle: Bundle(for: ConferenceDetailSectionHeaderView.self))
        collectionView.register(sectionHeader, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ConferenceDetailSectionHeaderView.className)

        collectionView.registerNib(VideosCollectionViewCell.self)

        title = viewModel.conferenceMetaData.name
    }

    override func setupBindings() {
        super.setupBindings()

        viewModel.notification
            .bind(to: self.rx.notification)
            .disposed(by: disposeBag)

        viewModel.toogleStateView
            .bind(to: self.rx.toogleStateView)
            .disposed(by: disposeBag)

        let dataSource = RxCollectionViewSectionedReloadDataSource<ConferenceDetailSectionModel>(configureCell: { [weak self] (dataSource, collectionView, indexPath, video) -> UICollectionViewCell in
            let videoCell = collectionView.dequeueReusableCell(withReuseIdentifier: VideosCollectionViewCell.className, for: indexPath) as! VideosCollectionViewCell

            videoCell.videoView.titleLabel.text = video.name

            videoCell.videoView.authorNameLabel.text = video.authors.first?.name

            if let previewImage = self?.viewModel.previewImage(for: video) {
                videoCell.videoView.previewImageView.image = previewImage
            } else {
                videoCell.videoView.previewImageView.isHidden = true
            }

            return videoCell
        })

        //((RxDataSources.CollectionViewSectionedDataSource<Section>, UICollectionView, String, IndexPath) -> UICollectionReusableView)?
        dataSource.configureSupplementaryView = { [weak self] (dataSource, collectionView, kind, indexPath) in
            guard kind == UICollectionView.elementKindSectionHeader else {
                fatalError("collectionView doesn't suppoer other type of supplementary view")
            }

            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ConferenceDetailSectionHeaderView.className, for: indexPath) as! ConferenceDetailSectionHeaderView

            headerView.backgroundColor = .green
            headerView.titleLabel.text = self?.viewModel.sectionTitle(for: indexPath.section)

            return headerView
        }

        viewModel.conferenceEditions
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

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

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 44.0)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = screenSize.width - 16*2
        return CGSize(width: cellWidth, height: 280)
    }
}
