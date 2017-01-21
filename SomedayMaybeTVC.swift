import UIKit
import RxSwift
import RxCocoa
import RealmSwift
import RxRealm

protocol SomedayMaybeTVCDelegate: class {
    func somedayMaybeTVC(_ somedayMaybeTVC: SomedayMaybeTVC, didSelectItem item: Item)
}

class SomedayMaybeTVC: UIViewController {
    
    weak var delegate: SomedayMaybeTVCDelegate!
    
    var items: Results<Item>!
    
    let tableView = UITableView()
    override func loadView() {
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = RLM.objects(Item.self).filter("itemTypeInt == 4")
        
        tableView.register(UITableViewCell.self)
        Observable.from(items).bindTo(tableView.rx.items(cellIdentifier: UITableViewCell.reuseIdentifier, cellType: UITableViewCell.self)) { index, item, cell in
            cell.textLabel?.text = item.detail
            }.addDisposableTo(db)
        
        tableView.rx.modelSelected(Item.self).subscribe(onNext: { item in
            self.delegate.somedayMaybeTVC(self, didSelectItem: item)
        }).addDisposableTo(db)
        
        tableView.rx.itemDeleted.subscribe(onNext: { indexPath in
            let removed = self.items[indexPath.row]
            removed.delete()
        }).addDisposableTo(db)
    }
    
    let db = DisposeBag()
}
