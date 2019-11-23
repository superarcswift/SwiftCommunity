//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation
import UIKit

class OpenConferenceTableViewCell: UITableViewCell, ClassNameDerivable {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    var conference: OpenConference? {
        didSet {
            guard let conference = conference else {
                return
            }

            nameLabel.text = conference.name

            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale.current
            dateFormatter.dateStyle = .medium

            var dateString = ""
            if let startDate = conference.startDate {
                dateString += dateFormatter.string(from: startDate)
            }
            dateString += " - "
            if let endDate = conference.startDate {
                dateString += dateFormatter.string(from: endDate)
            }
            dateLabel.text = dateString
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        conference = nil
    }
}
