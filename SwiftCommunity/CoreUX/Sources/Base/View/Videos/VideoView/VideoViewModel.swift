//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import DataModels
import SuperArcCoreUI
import SuperArcCore
import UIKit.UIImage

public class VideoViewModel: ViewModel {

    // MARK: Properties

    // Public

    public var videoMetaData: VideoMetaData

    public var name: String {
        return videoMetaData.name
    }

    public var authors: [(name: String, avatarImage: UIImage)] {
        return videoMetaData.authors.map {
            (name: $0.name, avatarImage: avatarImage(for: $0))
        }
    }

    public var conferenceName: String {
        return "\(videoMetaData.conference.metaData.name) \(conferenceEditionYear)"
    }

    public var conferenceEditionYear: Int {
        return videoMetaData.conference.edition.year
    }

    public var previewImage: (image: UIImage, contentMode: UIView.ContentMode) {
        guard let previewImageURL = videosService.previewImageURL(for: videoMetaData) else {
            return (image: defaultPreviewView, contentMode: .scaleAspectFit)
        }

        guard let previewImage = UIImage(contentsOfFile: previewImageURL.path) else {
            return (image: defaultPreviewView, contentMode: .scaleAspectFit)
        }

        return (image: previewImage, contentMode: .scaleAspectFill)
    }

    // Private

    private var videosService: VideosServiceProtocol
    private var authorsService: AuthorsServiceProtocol

    private var defaultPreviewView = UIImage.named("video_default", bundleClass: VideoViewModel.self)!.withRenderingMode(.alwaysTemplate)
    private var defaultAuthorImage = UIImage.named("author_default", bundleClass: VideoViewModel.self)!.withRenderingMode(.alwaysTemplate)

    // MARK: Initialization

    public init(videoMetaData: VideoMetaData, videosService: VideosServiceProtocol, authorsService: AuthorsServiceProtocol) {
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
    public static func == (lhs: VideoViewModel, rhs: VideoViewModel) -> Bool {
        return lhs.videoMetaData.id == rhs.videoMetaData.id
    }
}
