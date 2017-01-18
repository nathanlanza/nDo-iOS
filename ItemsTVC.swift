import UIKit
import RxSwift
import RxCocoa
import RealmSwift

protocol ItemsTVCDelegate: class {
    func itemsTVC(_ itemsTVC: ItemsTVC, didSelectItem item: Item)
    func newItemTapped(for itemsTVC: ItemsTVC)
}

class ItemsTVC: UIViewController {
    
    weak var delegate: ItemsTVCDelegate!
    
    var items: Results<Item>! {
        didSet {
            let a = Array(items)
            Observable.of(a)
                .bindTo(tableView.rx.items(cellIdentifier: UITableViewCell.reuseIdentifier, cellType: UITableViewCell.self)) { index, value, cell in
                    cell.textLabel?.text = value.detail
                }.addDisposableTo(db)
            
            tableView.rx.modelSelected(Item.self).subscribe(onNext: { item in
                self.delegate.itemsTVC(self, didSelectItem: item)
            }).addDisposableTo(db)
        }
    }
    
    let tableView = UITableView()
    override func loadView() {
        view = tableView
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        items = RLM.objects(Item.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem?.rx.tap.subscribe(onNext: {
            self.delegate.newItemTapped(for: self)
        }).addDisposableTo(db)
    }
    
    let db = DisposeBag()
}
