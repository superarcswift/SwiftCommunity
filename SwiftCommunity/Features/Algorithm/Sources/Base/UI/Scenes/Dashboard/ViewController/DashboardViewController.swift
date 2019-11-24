//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import SuperArcActivityIndicator
import SuperArcLocalization
import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import RxDataSources
import RxSwift
import UIKit

protocol DashboardNavigationDelegate: class {
    func show(_ sectionID: String?, from navigationController: UINavigationController?)
}

class DashboardTableViewController: TableViewController<DashboardViewModel>, StoryboardInitiable {

    // MARK: Properties

    // Static

    static var storyboardName = "Dashboard"

    // Private

    private let disposeBag = DisposeBag()

    // Public

    weak var delegate: DashboardNavigationDelegate?

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

        let dataSource = RxTableViewSectionedReloadDataSource<AlgorithmSectionModel>(configureCell: { (_, tableView, indexPath, item) -> UITableViewCell in
            switch item {
                case .content(let content):
                    return self.makeContentCell(with: content, from: tableView)
                case .section(let section):
                    return self.makeSectionsCell(with: section, from: tableView)
            }
        })

        viewModel.outputs.section.asObservable()
            .flatMap({ section -> Observable<[AlgorithmSectionModel]> in
                var tableViewSections = [AlgorithmSectionModel]()
                if let content = section?.content {
                    tableViewSections.append(AlgorithmSectionModel(items: [AlgorithmSectionDataModel.content(content)]))
                }
                if let sections = section?.sections {
                    let items = sections.map { AlgorithmSectionDataModel.section($0) }
                    tableViewSections.append(AlgorithmSectionModel(items: items))
                }

                return Observable.just(tableViewSections)
            })
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(Section.self)
            .subscribe( onNext: { [unowned self] section in
                self.delegate?.show(section.id, from: self.navigationController)
            })
            .disposed(by: disposeBag)
    }

    override func loadData() {
        super.loadData()

        viewModel.loadData(sectionID: nil)
    }

    // MARK Private helpers

    func makeContentCell(with content: Content, from tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(MarkdownContentTableViewCell.self)
        cell.content = content
        cell.onRendered = { [weak tableView] in
            // Hacky workaround to relayout the cell so that we get the correct height after the content is loaded.
            tableView?.beginUpdates()
            tableView?.endUpdates()
        }
        return cell
    }

    func makeSectionsCell(with section: Section, from tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(SectionTableViewCell.self)
        cell.section = section
        return cell
    }
}
