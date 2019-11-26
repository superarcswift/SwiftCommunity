//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import SuperArcActivityIndicator
import SuperArcLocalization
import SuperArcCoreUI
import SuperArcCoreComponent
import SuperArcCore
import SuperArcFoundation
import RxDataSources
import RxSwift
import UIKit

class ContentTableViewController: TableViewController<ContentTableViewModel>, StoryboardInitiable {

    // MARK: Properties

    // Static

    static var storyboardName = "Content"

    // Private

    private let disposeBag = DisposeBag()

    // Public

    var builder: UnownedWrapper<AlgorithmComponent>?

    var sectionID: String?

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

        viewModel.toggleEmptyState
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.toogleStateView)
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

        viewModel.isReady
            .subscribe( onNext: { [weak self] isReady in
                guard isReady else {
                    return
                }
                self?.viewModel.loadData(sectionID: self?.sectionID)
            })
            .disposed(by: disposeBag)

        let dataSource = RxTableViewSectionedReloadDataSource<AlgorithmSectionModel>(configureCell: { (_, tableView, indexPath, item) -> UITableViewCell in
            switch item {
                case .content(let content):
                    return self.makeContentCell(with: content, from: tableView, for: indexPath)
                case .section(let section):
                    return self.makeSectionsCell(with: section, from: tableView, for: indexPath)
            }
        })

        viewModel.outputs.section.asObservable()
            .flatMap({ section -> Observable<[AlgorithmSectionModel]> in
                var tableViewSections = [AlgorithmSectionModel]()
                if let sections = section?.sections {
                    let items = sections.map { AlgorithmSectionDataModel.section($0) }
                    tableViewSections.append(AlgorithmSectionModel(items: items))
                }
                if let content = section?.content {
                    tableViewSections.append(AlgorithmSectionModel(items: [AlgorithmSectionDataModel.content(self.viewModel.contentViewModel(for: content))]))
                }

                return Observable.just(tableViewSections)
            })
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(AlgorithmSectionDataModel.self)
            .subscribe(
                onNext: { [unowned self] sectionDataModel in
                    switch sectionDataModel {
                        case .section(let section):
                            self.show(section.id)
                        default:
                            break
                    }
                }
            )
            .disposed(by: disposeBag)
    }

    override func loadData() {
        super.loadData()

        if let sectionID = sectionID {
            viewModel.loadData(sectionID: sectionID)
        } else {
            viewModel.prepareLocalRepository(shouldResetBeforeCloning: false)
        }
    }

    // MARK: Private helpers

    private func makeContentCell(with contentViewModel: ContentViewModel, from tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(MarkdownContentTableViewCell.self, for: indexPath)
        cell.contentViewModel = contentViewModel
        cell.onRendered = { [weak tableView] in
            // Hacky workaround to relayout the cell so that we get the correct height after the content is loaded.
            tableView?.beginUpdates()
            tableView?.endUpdates()
        }
        return cell
    }

    private func makeSectionsCell(with section: Section, from tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(SectionTableViewCell.self, for: indexPath)
        cell.section = section
        return cell
    }

    private func show(_ sectionID: String) {
        guard let builder = builder else {
            return
        }

        let viewController = builder.wrappedValue.makeDashboardViewController(forSection: sectionID, with: builder)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
