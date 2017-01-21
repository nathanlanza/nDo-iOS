import UIKit
import RxSwift
import RxCocoa
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

class ItemVC: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    override func loadView() {
        view = tableView
    }
    
    init(item: Item) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    let item: Item
    
    let stackView = UIStackView(axis: .vertical, spacing: 8, distribution: .fillEqually)
    
    
    func setupTableView() {
    }
    
    
    
    let db = DisposeBag()
}

struct Things {
    var int: Int
    var string: String
}

struct SectionOfThings {
    var header: String
    var items: [Item]
}
extension SectionOfThings: SectionModelType {
