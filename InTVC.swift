import UIKit
import RxSwift
import RxCocoa
import RealmSwift

protocol InTVCDelegate: class {
    func inTVC(_ inTVC: InTVC, didSelectIn note: Item)
}

class InTVC: UIViewController {
    
    weak var delegate: InTVCDelegate!
    
    let tableView = UITableView()
    override func loadView() {
        view = tableView
    }
    
    var items: Results<Item>! {
        didSet {
            variable.value = Array(items)
        }
    }
    let variable = Variable([Item]())
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        items = RLM.objects(Item.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        
        tableView.register(UITableViewCell.self)
        variable.asObservable().bindTo(tableView.rx.items(cellIdentifier: UITableViewCell.reuseIdentifier, cellType: UITableViewCell.self)) { index, value, cell in
            cell.textLabel?.text = value.note
            }.addDisposableTo(db)
        
        tableView.rx.modelSelected(Item.self).subscribe(onNext: { capturedNote in
            self.delegate.inTVC(self, didSelectItem: capturedNote)
        }).addDisposableTo(db)
        
        tableView.rx.itemDeleted.subscribe(onNext: { indexPath in
            let removed = self.variable.value.remove(at: indexPath.row)
            removed.delete()
        }).addDisposableTo(db)
        
    }
    
    let db = DisposeBag()
}
