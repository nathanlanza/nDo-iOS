import UIKit
import RxSwift
import RxCocoa
import RealmSwift

protocol ItemsTVCDelegate: class {
    func itemsTVC(_ itemsTVC: ItemsTVC, didSelectItem item: Item)
}

class ItemsTVC: UIViewController {
    
    weak var delegate: ItemsTVCDelegate!
    
    var items: Results<Item>!
    
    let tableView = UITableView()
    override func loadView() {
        view = tableView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        items = Realm.objects(Item.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self)
        Observable.of(items).bindTo(tableView.rx.items(cellIdentifier: UITableViewCell.reuseIdentifier, cellType: UITableViewCell.self)) { index, value, cell in
            cell.textLabel?.text = value
            }.addDisposableTo(db)
        
        tableView.rx.modelSelected(Item.self).subscribe(onNext: { item in
            self.delegate.itemsTVC(self, didSelectItem: item)
        }).addDisposableTo(db)
    }
    
    let db = DisposeBag()
}
