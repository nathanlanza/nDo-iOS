import UIKit
import RxSwift
import RxCocoa
import RealmSwift

protocol NextActionsTVCDelegate: class {
    func nextActionsTVC(_ nextActionsTVC: NextActionsTVC, didSelectItem item: Item)
    func newItemTapped(for itemsTVC: NextActionsTVC)
}

class NextActionsTVC: UIViewController {
    
    weak var delegate: NextActionsTVCDelegate!
    
    var items: Results<Item>! {
        didSet {
            variable.value = Array(items)
        }
    }
    let variable = Variable([Item]())
    
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
        variable.asObservable().bindTo(tableView.rx.items(cellIdentifier: UITableViewCell.reuseIdentifier, cellType: UITableViewCell.self)) { index, value, cell in
                cell.textLabel?.text = value.detail
            }.addDisposableTo(db)
        
        tableView.rx.modelSelected(Item.self).subscribe(onNext: { item in
            self.delegate.nextActionsTVC(self, didSelectItem: item)
        }).addDisposableTo(db)
        
        tableView.rx.itemDeleted.subscribe(onNext: { indexPath in
            let removed = self.variable.value.remove(at: indexPath.row)
            removed.delete()
        }).addDisposableTo(db)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem?.rx.tap.subscribe(onNext: {
            self.delegate.newItemTapped(for: self)
        }).addDisposableTo(db)
    }
    
    let db = DisposeBag()
}
