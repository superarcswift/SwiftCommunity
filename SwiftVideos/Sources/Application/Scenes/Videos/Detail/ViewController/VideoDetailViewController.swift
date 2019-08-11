//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import RxCocoa
import RxSwift
import UIKit

class VideoDetailViewController: ViewController<VideoDetailViewModel>, StoryboardInitiable {

    // MARK: Properties

    // Static

    static var storyboardName = "Videos"

    // IBOutlets

    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var startVideoPlayerButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    private let disposeBag = DisposeBag()


    // MARK: Overrides

    override func setupBindings() {
        super.setupBindings()

        viewModel.notification
            .bind(to: self.rx.notification)
            .disposed(by: disposeBag)

        viewModel.toogleStateView
            .bind(to: self.rx.toogleStateView)
            .disposed(by: disposeBag)

        startVideoPlayerButton.rx.tap
            .bind(to: viewModel.startVideoPlayerTrigger)
            .disposed(by: disposeBag)

        viewModel.previewVideoImage.asObservable()
            .bind(to: previewImageView.rx.image)
            .disposed(by: disposeBag)

        viewModel.videoDetail.subscribe { [weak self] event in
            guard let video = event.element else {
                return
            }

            self?.nameLabel.text = video?.metaData.name
            self?.descriptionLabel.text = video?.description

        }.disposed(by: disposeBag)

    }
    
    override func loadData() {
        viewModel.loadData()
    }
}
