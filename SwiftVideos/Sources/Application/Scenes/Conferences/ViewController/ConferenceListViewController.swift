//
//  Copyright © 2019 An Tran. All rights reserved.
//

import UIKit

class ConferenceListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let video = Video(uuid: UUID(), name: "Name", source: .url(url: "https://www.google.com"))
        let jsonEncoder = JSONEncoder()
        let encodedVideo = try? jsonEncoder.encode(video)

        if let data = encodedVideo, let str = String(data: data, encoding: .utf8) {
            print(str)
        }

    }

}

