//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import RxCocoa
import RxSwift
import UIKit

class AuthorDetailViewController: ViewController, StoryboardInitiable {

    // MARK: Properties

    // Static

    static var storyboardName = "Authors"

    enum Section: Int, CaseIterable {
        case avatar
        case resources
//        case videos
    }

    // IBOutlet

    @IBOutlet weak var tableView: UITableView!

    // Public

    var viewModel: AuthorDetailViewModel {
        return storedViewModel as! AuthorDetailViewModel
    }

    // Private

    private var disposeBag = DisposeBag()

    // MARK: Overrides

    override func setupViews() {
        super.setupViews()

        tableView.dataSource = self
        tableView.delegate = self

        tableView.tableFooterView = UIView(frame: .zero)

        //tableView.registerNib(AuthorAvatarTableViewCell.self)
    }

    override func setupBindings() {
        super.setupBindings()

        viewModel.notification
            .bind(to: self.rx.notification)
            .disposed(by: disposeBag)

        viewModel.toogleStateView
            .bind(to: self.rx.toogleStateView)
            .disposed(by: disposeBag)

        viewModel.authorDetail.bind { [weak self] authorDetail in
            if authorDetail != nil {
                self?.tableView.reloadData()
            }
        }.disposed(by: disposeBag)
    }

    override func loadData() {
        viewModel.loadData()
    }
}

extension AuthorDetailViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section) {
        case .avatar?:
            return 1
        case .resources?:
            return viewModel.authorDetail.value?.resources.count ?? 0
        default:
            fatalError("invalid section")
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Section(rawValue: indexPath.section) {
        case .avatar?:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AuthorAvatarTableViewCell", for: indexPath) as! AuthorAvatarTableViewCell

            if let authorDetail = viewModel.authorDetail.value {
                cell.authorView.nameLabel.text = authorDetail.metaData.name
                cell.authorView.avatarImageView.image = viewModel.avatarImage(of: authorDetail.metaData)
            }

            return cell

        case .resources?:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AuthorResourcesTableViewCell", for: indexPath) as! AuthorResourcesTableViewCell

            if let authorDetail = viewModel.authorDetail.value {
                for resource in authorDetail.resources {
                    cell.typeLabel.text = resource.type
                    cell.valueLabel.text = resource.value
                }
            }

            return cell

        default:
            fatalError("invalid section")
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch Section(rawValue: indexPath.section) {
        case .avatar?:
            return 170
        case .resources?:
            return 44
        default:
            fatalError("invalid section")
        }
    }
}

extension AuthorDetailViewController: UITableViewDelegate {

}
