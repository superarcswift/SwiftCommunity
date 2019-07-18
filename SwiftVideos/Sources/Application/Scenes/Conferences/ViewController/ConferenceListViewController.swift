//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import RxSwift
import UIKit

class ConferenceListViewController: ViewController, StoryboardInitiable {

    // MARK: Properties

    // Static

    static var storyboardName = "Conferences"

    // IBOutlets

    @IBOutlet weak var collectionView: UICollectionView!

    // Private

    private var viewModel: ConferenceListViewModel {
        return storedViewModel as! ConferenceListViewModel
    }

    private let disposeBag = DisposeBag()

    // MARK: Lifecycles

    override func setupViewModel() -> ViewModel! {
        return ConferenceListViewModel(engine: context.engine)
    }

    override func setupViews() {
        super.setupViews()

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.registerNib(ConferenceCollectionViewCell.className, bundle: Bundle(for: ConferenceCollectionViewCell.self))
    }

    override func setupBindings() {
        super.setupBindings()

        viewModel.conferences.subscribe(
            onNext: { conferences in
                self.collectionView.reloadData()
            }
        ).disposed(by: disposeBag)
    }

    override func loadData() {
        viewModel.loadData()
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
        return viewModel.conferences.value.count
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
