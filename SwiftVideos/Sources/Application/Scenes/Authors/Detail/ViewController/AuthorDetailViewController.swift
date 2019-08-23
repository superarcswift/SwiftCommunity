//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import RxCocoa
import RxSwift
import UIKit

class AuthorDetailViewController: ViewController<AuthorDetailViewModel>, StoryboardInitiable {

    // MARK: Properties

    // Static

    static var storyboardName = "Authors"

    enum Section: Int, CaseIterable {
        case avatar
        case resources
        case videos

        static func from(rawValue: Int) -> Section {
            guard let section = Section(rawValue: rawValue) else {
                fatalError("invalid section")
            }

            return section
        }
    }

    // IBOutlet

    @IBOutlet weak var tableView: UITableView!

    // Private

    private var disposeBag = DisposeBag()

    // MARK: Overrides

    override func setupViews() {
        super.setupViews()

        tableView.dataSource = self
        tableView.delegate = self

        tableView.tableFooterView = UIView(frame: .zero)

        tableView.registerNib(VideosTableViewCell.self)

        title = viewModel.authorMetaData.name
    }

    override func setupBindings() {
        super.setupBindings()

        viewModel.notification
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.notification)
            .disposed(by: disposeBag)

        viewModel.toogleStateView
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.toogleStateView)
            .disposed(by: disposeBag)

        viewModel.outputs.authorDetail.bind { [weak self] authorDetail in
            if authorDetail != nil {
                self?.tableView.reloadData()
            }
        }.disposed(by: disposeBag)

        viewModel.outputs.videos.subscribe { [weak self] event in
            if event.element != nil {
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
        switch Section.from(rawValue: section) {
        case .avatar:
            return 1

        case .resources:
            return viewModel.authorDetail.value?.resources.count ?? 0

        case .videos:
            return viewModel.videos.value?.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Section(rawValue: indexPath.section) {
        case .avatar?:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AuthorAvatarTableViewCell", for: indexPath) as! AuthorAvatarTableViewCell

            cell.authorView.viewModel = viewModel.authorViewModel

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

        case .videos?:

            let videoCell = tableView.dequeueReusableCell(VideosTableViewCell.self, for: indexPath)

            if let videoViewModel = viewModel.videos.value?[indexPath.row] {
                videoCell.videoView.viewModel = videoViewModel
            }

            return videoCell

        default:
            fatalError("invalid section")
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch Section.from(rawValue: indexPath.section) {

        case .avatar:
            return 138

        case .resources:
            return 44

        case .videos:
            return 300

        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch Section.from(rawValue: section) {

        case .resources:
            if let count = viewModel.authorDetail.value?.resources.count, count > 0 {
                return 12.0
            }

            return 0

        default:
            return 12.0
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch Section.from(rawValue: section) {

        case .resources:
            if let count = viewModel.authorDetail.value?.resources.count, count > 0 {
                return 12.0
            }

            return 0

        default:
            return 12.0
        }
    }
}

extension AuthorDetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch Section.from(rawValue: indexPath.section) {

        case .resources:
            if let authorDetail = viewModel.authorDetail.value {
                let resource = authorDetail.resources[indexPath.row]
                switch resource {
                case .github(url: let urlOrNil):
                    guard let url = urlOrNil else { return }
                    UIApplication.shared.open(url, options: [:])
                    break
                case .homepage(url: let urlOrNil):
                    guard let url = urlOrNil else { return }
                    UIApplication.shared.open(url, options: [:])
                    break
                case .linkedin(url: let urlOrNil):
                    guard let url = urlOrNil else { return }
                    UIApplication.shared.open(url, options: [:])
                    break
                }
            }

        case .videos:
            if let video = viewModel.videos.value?[indexPath.row] {
                viewModel.present(video)
            }

        default:
            break
        }
    }
}
