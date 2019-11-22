//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import RxSwift
import UIKit

class MoreTableViewController: TableViewController<MoreViewModel>, StoryboardInitiable {

    // MAK: Properties

    // Static

    static var storyboardName = "More"

    enum Section: Int {
        case conferences
        case about
        case licenses
        case contact
        case reset

        enum LicensesRows: Int {
            case acknowledgements
            case contentLicense
        }
    }

    // Private

    private let disposeBag = DisposeBag()

    // MARK: Overrides

    override func setupViews() {
        super.setupViews()

        tableView.rowHeight = Constants.UI.defaultRowHeight
        tableView.tableFooterView = UIView(frame: .zero)
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
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch Section(rawValue: indexPath.section) {
            case .conferences?:
                viewModel.router.trigger(.conferences)
            case .about?:
                viewModel.router.trigger(.about)
            case .licenses?:
                switch Section.LicensesRows(rawValue: indexPath.row) {
                    case .acknowledgements?:
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, completionHandler: nil)
                    case .contentLicense?:
                        viewModel.router.trigger(.contentLicense)
                    default:
                        fatalError("invalid row")
                }
            case .contact?:
                UIApplication.shared.open(URL(string: "https://twitter.com/swift_community")!, completionHandler: nil)
            case .reset?:
                confirmReset()
            default:
                fatalError("invalid section")
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: Private helpers

    func confirmReset() {
        let alert = UIAlertController(title: "Confirmation", message: "Do you really want to reset the local repository?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
            self?.viewModel.reset()
        }
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)

        alert.addAction(confirmAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }
}
