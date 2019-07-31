//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import RxCocoa
import RxSwift
import UIKit

class VideoDetailViewController: ViewController, StoryboardInitiable {

    // MARK: Properties

    // Static

    static var storyboardName = "Videos"

    // IBOutlets

    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var startVideoPlayerButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    // Private

    private var viewModel: VideoDetailViewModel {
        return storedViewModel as! VideoDetailViewModel
    }

    private let disposeBag = DisposeBag()


    // MARK: Overrides

    override func setupBindings() {
        super.setupBindings()

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

    override func setupViews() {
        prefersLargeTitles = false
        super.setupViews()
    }

    override func loadData() {
        viewModel.loadData()
    }
}
