//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SwiftVideos_Core
import SwiftVideos_DataModels
import SuperArcCoreUI
import SuperArcCore
import UIKit.UIImage

class VideoViewModel: ViewModel {

    // MARK: Properties

    // Public

    var videoMetaData: VideoMetaData

    var name: String {
        return videoMetaData.name
    }

    var authors: [(name: String, avatarImage: UIImage)] {
        return videoMetaData.authors.map {
            (name: $0.name, avatarImage: avatarImage(for: $0))
        }
    }

    var conferenceName: String {
        return "\(videoMetaData.conference.metaData.name) \(conferenceEditionYear)"
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
    private var authorsService: AuthorsService

    private var defaultPreviewView = UIImage(imageLiteralResourceName: "video_default").withRenderingMode(.alwaysTemplate)
    private var defaultAuthorImage = UIImage(imageLiteralResourceName: "author_default").withRenderingMode(.alwaysTemplate)

    // MARK: Initialization

    init(videoMetaData: VideoMetaData, videosService: VideosService, authorsService: AuthorsService) {
        self.videoMetaData = videoMetaData
        self.videosService = videosService
        self.authorsService = authorsService
        super.init()
    }

    // MARK: Private helpers

    func avatarImage(for author: AuthorMetaData) -> UIImage {
        guard let avatarImageURL = authorsService.avatar(of: author) else {
            return defaultAuthorImage
        }

        guard let avatarImage = UIImage(contentsOfFile: avatarImageURL.path) else {
            return defaultAuthorImage
        }

        return avatarImage
    }
}

extension VideoViewModel: Equatable {
    static func == (lhs: VideoViewModel, rhs: VideoViewModel) -> Bool {
        return lhs.videoMetaData.id == rhs.videoMetaData.id
    }
}
