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
        itemsTVC.delegate = self
    }
}

extension ItemsCoordinator: ItemsTVCDelegate {
    func itemsTVC(_ itemsTVC: ItemsTVC, didSelectItem item: Item) {
        let iic = ItemCoordinator(item: item)
        show(iic, sender: self)
    }
}

class ItemsTVC: UIViewController {
   
    weak var delegate: ItemsTVCDelegate!
    
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
        
        tableView.rx.modelSelected(Item.self).subscribe(onNext: { item in
            self.delegate.itemsTVC(self, didSelectItem: item)
        }).addDisposableTo(db)
    }
    
    let db = DisposeBag()
}

protocol ItemsTVCDelegate: class {
    func itemsTVC(_ itemsTVC: ItemsTVC, didSelectItem item: Item) 
}


class ItemCoordinator: Coordinator {
    
    let item: Item
    
    init(item: Item? = nil) {
        self.item = item ?? Item()
        super.init()
    }

    let itemVC = ItemVC()
    override func loadViewController() {
        viewController = itemVC
        itemVC.item = item
    }
}

class ItemVC: UIViewController {
    
    var item: Item! {
        didSet {
            detailTextField.text = item.detail
            firstStepTextField.text = item.firstStep
            finishedConditionTextField.text = item.finishedCondition
        }
    }
    
    let stackView = UIStackView(axis: .vertical, spacing: 8, distribution: .fillEqually)
    
    let detailTextField = UITextField()
    let firstStepTextField = UITextField()
    let finishedConditionTextField = UITextField()
    
    func setupViews() {
        [detailTextField,firstStepTextField,finishedConditionTextField].forEach {
            stackView.addArrangedSubview($0)
        }
       
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupViews()
        setupRx()
    }
    
    func setupRx() {
        detailTextField.rx.controlEvent(.editingDidEnd).subscribe(onNext: {
            self.item.detail = self.detailTextField.text ?? ""
        }).addDisposableTo(db)
        firstStepTextField.rx.controlEvent(.editingDidEnd).subscribe(onNext: {
            self.item.firstStep = self.firstStepTextField.text ?? ""
        }).addDisposableTo(db)
        finishedConditionTextField.rx.controlEvent(.editingDidEnd).subscribe(onNext: {
            self.item.finishedCondition = self.finishedConditionTextField.text ?? ""
        }).addDisposableTo(db)
    }
    let db = DisposeBag()
}
