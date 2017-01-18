import CoordinatorKit
import RxSwift
import RxCocoa
import Reuse

class MainCoordinator: NavigationCoordinator {
    static let main = MainCoordinator()
    override init() {
        super.init(rootCoordinator: ItemsCoordinator())
    }
    
    override func viewControllerDidLoad() {
        super.viewControllerDidLoad()
        //initial setup
    }
}

class ItemsCoordinator: Coordinator {
    var itemsTVC: ItemsTVC { return viewController as! ItemsTVC }
    override func loadViewController() {
        viewController = ItemsTVC()
    }
}

class ItemsTVC: UIViewController {
    let tableView = UITableView()
    override func loadView() {
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self)
        Observable.of(["one","two","three"]).bindTo(tableView.rx.items(cellIdentifier: UITableViewCell.reuseIdentifier, cellType: UITableViewCell.self)) { index, value, cell in
            cell.textLabel?.text = value
        }.addDisposableTo(db)
    }
    
    let db = DisposeBag()
}
