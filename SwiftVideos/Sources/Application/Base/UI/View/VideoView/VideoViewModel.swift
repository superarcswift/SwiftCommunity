//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import UIKit.UIView

class VideoViewModel: ViewModel {

    // MARK: Properties

    // Public

    var videoMetaData: VideoMetaData

    var name: String {
        return videoMetaData.name
    }

    var authors: String {
        return videoMetaData.authors.map { $0.name }.joined(separator: ", ")
    }

    var conferenceEditionYear: Int {
        return videoMetaData.conference.edition.year
    }

    var previewImage: (image: UIImage, contentMode: UIView.ContentMode) {
        guard let previewImageURL = videosService.previewImageURL(for: videoMetaData) else {
            return (image: defaultPreviewView, contentMode: .scaleAspectFit)
        }

        guard let previewImage = UIImage(contentsOfFile: previewImageURL.path) else {
            return (image: defaultPreviewView, contentMode: .scaleAspectFit)
        }

        return (image: previewImage, contentMode: .scaleAspectFill)
    }

    // Private

    private var videosService: VideosService
    private var defaultPreviewView = UIImage(imageLiteralResourceName: "video_default").withRenderingMode(.alwaysTemplate)

    // MARK: Initialization

    init(videoMetaData: VideoMetaData, videosService: VideosService) {
        self.videoMetaData = videoMetaData
        self.videosService = videosService
        super.init()
    }
}

extension VideoViewModel: Equatable {
    static func == (lhs: VideoViewModel, rhs: VideoViewModel) -> Bool {
        return lhs.videoMetaData.id == rhs.videoMetaData.id
    }
}
