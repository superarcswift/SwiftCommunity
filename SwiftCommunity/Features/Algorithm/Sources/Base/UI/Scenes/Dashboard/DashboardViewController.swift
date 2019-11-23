//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import SuperArcActivityIndicator
import SuperArcLocalization
import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import RxSwift
import UIKit

class DashboardTableViewController: TableViewController<DashboardViewModel>, StoryboardInitiable {

    // MARK: Properties

    // Static

    static var storyboardName = "Dashboard"

    // Private

    private let disposeBag = DisposeBag()

    // MARK: Lifecycles

    override public func setupBindings() {
        super.setupBindings()

        viewModel.notification
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.notification)
            .disposed(by: disposeBag)

        viewModel.outputs.section.asObservable()
            .observeOn(MainScheduler.instance)
            .bind { [unowned self] section in
                guard let section = section else {
                    return
                }
                self.title = section.title
            }
            .disposed(by: disposeBag)

        viewModel.outputs.section.asObservable()
            .flatMap({ section -> Observable<[Section]> in
                Observable.just(section?.sections ?? [])
            })
            .bind(to: tableView.rx.items(cellIdentifier: SectionTableViewCell.className)) { _, section, cell in
                guard let sectionCell = cell as? SectionTableViewCell else {
                    fatalError("wrong cell type")
                }
                sectionCell.section = section
        }.disposed(by: disposeBag)

        tableView.rx.modelSelected(Section.self)
            .bind(to: viewModel.inputs.didSelectSectionTrigger)
            .disposed(by: disposeBag)
    }

    override func loadData() {
        super.loadData()

        viewModel.loadData(sectionID: nil)
    }
}
