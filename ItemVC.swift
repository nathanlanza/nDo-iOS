import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Reuse

extension Reactive where Base: UITableView {
    public func items<S: Sequence, Cell: UITableViewCell, O : ObservableType>
        (cellType: Cell.Type = Cell.self)
        -> (_ source: O)
        -> (_ configureCell: @escaping (Int, S.Iterator.Element, Cell) -> Void)
        -> Disposable
        where O.E == S, Cell: ReusableView {
            return items(cellIdentifier: cellType.reuseIdentifier, cellType: cellType)
    }
}

protocol ItemVCDelegate: class {
    func projectsSelected()
}

class ItemVC: UIViewController {
    required init?(coder aDecoder: NSCoder) { fatalError() }
    init(item: Item) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    weak var delegate: ItemVCDelegate!
    
    let item: Item
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func loadView() {
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupDataSource()
    }
    
    let dataSource = RxTableViewSectionedReloadDataSource<ItemSectionModel>()
    
    func setupTableView() {
        tableView.register(UITableViewCell.self)
        let sections = [ItemSectionModel.detail(item.detail)] + ItemSectionModel.sections
        Observable.just(sections).bindTo(tableView.rx.items(dataSource: dataSource)).addDisposableTo(db)
        
        tableView.rx.setDelegate(self).addDisposableTo(db)
    }
    var itemTypeToRowIndex: Int!
    func setupDataSource() {
        switch item.itemType {
        case .capture: break
        case .projectAction: break
        case .nextAction: itemTypeToRowIndex = 0
        case .waitingFor: itemTypeToRowIndex = 1
        case .somedayMaybe: itemTypeToRowIndex = 2
        case .reference: itemTypeToRowIndex = 3
        }
        dataSource.configureCell = { ds, tv, ip, item in
            let cell = tv.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: ip)
            cell.textLabel?.text = item
            cell.selectionStyle = .none
            
            if ip.section == 2, let ittrw = self.itemTypeToRowIndex, ittrw == ip.row {
                cell.accessoryType = .checkmark
            }
            
            return cell
        }
        dataSource.titleForHeaderInSection = { ds, index in
            return ds.sectionModels[index].title
        }
    }
    let db = DisposeBag()
}

extension ItemVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0: return 1
        default: return 30
        }
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard indexPath.section == 2 else { return indexPath }
        if let oldIndex = tableView.indexPathForSelectedRow {
            tableView.cellForRow(at: oldIndex)?.accessoryType = .none
            if oldIndex == indexPath {
                item.itemType = .capture
                return indexPath
            }
        }
        switch indexPath.row {
        case 0:
            item.itemType = .nextAction
        case 1:
            item.itemType = .waitingFor
        case 2:
            item.itemType = .somedayMaybe
        case 3:
            item.itemType = .reference
        default: fatalError()
        }
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            delegate.projectsSelected()
        }
    }
}


enum ItemSectionModel {
    case detail(String)
    case project(title: String, items: [String])
    case status(title: String, items: [String])
    case context(title: String, items: [String])
}
extension ItemSectionModel {
    static let sections: [ItemSectionModel] = [
        .project(title: "Project", items: ["Add to a project..."]),
        .status(title: "Status", items: ["Next Actions", "Waiting For", "Someday/Maybe", "Reference"]),
        .context(title: "Context", items: ["Add to context..."])
    ]
}
extension ItemSectionModel: SectionModelType {
    typealias Item = String
    var items: [String] {
        switch self {
        case .detail(let detail):
            return [detail]
        case .project(title: _, items: let items):
            return items.map {$0}
        case .status(title: _, items: let items):
            return items.map {$0}
        case .context(title: _, items: let items):
            return items.map {$0}
        }
    }
    init(original: ItemSectionModel, items: [String]) {
        switch original {
        case .detail(let string):
            self = .detail(string)
        case .project(title: let title, items: _):
            self = .project(title: title, items: items)
        case .status(title: let title, items: _):
            self = .status(title: title, items: items)
        case .context(title: let title, items: _):
            self = .context(title: title, items: items)
        }
    }
}
extension ItemSectionModel {
    var title: String {
        switch self {
        case .detail(_):
            return ""
        case .project(title: let title, items: _):
            return title
        case .status(title: let title, items: _):
            return title
        case .context(title: let title, items: _):
            return title
        }
    }
}
