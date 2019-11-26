//
//  Copyright © 2019 An Tran. All rights reserved.
//

import CoreUX
import Core
import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import RxDataSources
import RxSwift
import UIKit

class OpenConferencesViewController: TableViewController<OpenConferencesViewModel>, StoryboardInitiable {

    // MARK: Properties

    // Static

    static var storyboardName: String = "OpenConferences"

    // Private

    private let disposeBag = DisposeBag()

    // MARK: Lifecycles

    override public func setupBindings() {
        super.setupBindings()

        viewModel.activity.active
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.activity)
            .disposed(by: disposeBag)

        viewModel.notification
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.notification)
            .disposed(by: disposeBag)

        viewModel.toogleStateView
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.toogleStateView)
            .disposed(by: disposeBag)

        let dataSource = RxTableViewSectionedReloadDataSource<OpenConferenceSectionModel>(configureCell: { (_, tableView, indexPath, conference) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(OpenConferenceTableViewCell.self, for: indexPath)
            cell.conference = conference
            return cell
        })

        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].year.asString
        }

        viewModel.outputs.conferences
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(OpenConference.self)
            .bind { [unowned self] conference in
                self.showDetail(for: conference)
            }.disposed(by: disposeBag)
    }

    override public func loadData() {
        viewModel.loadData()
    }

    // MARK: Private helpers

    private func showDetail(for conference: OpenConference) {
        guard let url = conference.url else {
            return
        }

        UIApplication.shared.open(url)
    }
}
