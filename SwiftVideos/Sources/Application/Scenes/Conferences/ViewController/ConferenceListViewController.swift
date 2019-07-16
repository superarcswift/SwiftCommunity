//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation
import UIKit

class ConferenceListViewController: UIViewController {

    // MARK: Properties

    // IBOutlets

    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self

//        collectionView.register(ConferenceCollectionViewCell.self, forCellWithReuseIdentifier: ConferenceCollectionViewCell.className)
        collectionView.registerNib(ConferenceCollectionViewCell.className, bundle: Bundle(for: ConferenceCollectionViewCell.self))
    }

}

// MARK: - UICollectionViewDelegate

extension ConferenceListViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

// MARK: - UICollectionViewDataSource

extension ConferenceListViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConferenceCollectionViewCell.className, for: indexPath) as? ConferenceCollectionViewCell else {
            fatalError("wrong cell type")
        }

        return cell
    }

}

extension ConferenceListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = screenSize.width - 16*2
        return CGSize(width: cellWidth, height: 200)
    }
}
