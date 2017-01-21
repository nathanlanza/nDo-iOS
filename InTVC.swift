import UIKit
import RxSwift
import RxCocoa
import RealmSwift
import RxRealm

protocol InTVCDelegate: class {
    func inTVC(_ inTVC: InTVC, didSelectItem item: Item)
}

class InTVC: UIViewController {
    
    weak var delegate: InTVCDelegate!
    
    let tableView = UITableView()
    override func loadView() {
        view = tableView
    }
    
    var items: Results<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        items = RLM.objects(Item.self).filter("itemTypeInt == 0")
        setupTableView()
    }
    
    func setupTableView() {
        
        tableView.register(UITableViewCell.self)
        Observable.from(items).bindTo(tableView.rx.items(cellIdentifier: UITableViewCell.reuseIdentifier, cellType: UITableViewCell.self)) { index, value, cell in
            cell.textLabel?.text = value.detail
            }.addDisposableTo(db)
        
        tableView.rx.modelSelected(Item.self).subscribe(onNext: { capturedNote in
            self.delegate.inTVC(self, didSelectItem: capturedNote)
        }).addDisposableTo(db)
        
        tableView.rx.itemDeleted.subscribe(onNext: { indexPath in
            let removed = self.items[indexPath.row]
            removed.delete()
        }).addDisposableTo(db)
    }
    
    let db = DisposeBag()
}
