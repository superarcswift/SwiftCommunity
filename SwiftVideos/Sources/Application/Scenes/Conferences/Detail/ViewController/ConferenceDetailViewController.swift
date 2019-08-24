//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SwiftVideos_Core
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
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
        }

        title = viewModel.conferenceMetaData.name
    }

    override func setupBindings() {
        super.setupBindings()

        viewModel.notification
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.notification)
            .disposed(by: disposeBag)

        viewModel.toogleStateView
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.toogleStateView)
            .disposed(by: disposeBag)

        let dataSource = RxCollectionViewSectionedReloadDataSource<ConferenceDetailSectionModel>(configureCell: { (dataSource, collectionView, indexPath, videoViewModel) -> UICollectionViewCell in
            let videoCell = collectionView.dequeueReusableCell(withReuseIdentifier: VideosCollectionViewCell.className, for: indexPath) as! VideosCollectionViewCell

            videoCell.videoView.viewModel = videoViewModel

            return videoCell
        })

        dataSource.configureSupplementaryView = { [weak self] (dataSource, collectionView, kind, indexPath) in
            guard kind == UICollectionView.elementKindSectionHeader else {
                fatalError("collectionView doesn't support other type of supplementary view")
            }

            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ConferenceDetailSectionHeaderView.className, for: indexPath) as! ConferenceDetailSectionHeaderView

            headerView.backgroundColor = UIColor(hex: 0xC3C3C3)
            headerView.titleLabel.text = self?.viewModel.apis.sectionTitle(for: indexPath.section)

            return headerView
        }

        viewModel.outputs.conferenceEditions
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        collectionView.rx.modelSelected(VideoViewModel.self)
            .bind(to: viewModel.inputs.didSelectVideoTrigger)
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
        return CGSize(width: cellWidth, height: 310)
    }
}
