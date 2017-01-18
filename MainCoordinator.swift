import CoordinatorKit
import RealmSwift
import RxSwift
import RxCocoa
import Reuse


class MainCoordinator: TabBarCoordinator {
    static let main = MainCoordinator()
    
    override func viewControllerDidLoad() {
        super.viewControllerDidLoad()
        
        let ic = ItemCoordinator()
        let icNav = NavigationCoordinator(rootCoordinator: ic)
        icNav.tabBarItem.title = "Items"
        icNav.tabBarItem.image = #imageLiteral(resourceName: "routine")
        
        let cc = CaptureCoordinator()
        let ccNav = NavigationCoordinator(rootCoordinator: cc)
        ccNav.tabBarItem.image = #imageLiteral(resourceName: "newWorkout")
        ccNav.tabBarItem.title = "Capture"
        
        coordinators = [icNav]
        
        addButton(for: ccNav, at: 1)
    }
    
    
}

class CaptureCoordinator: Coordinator {
    let captureVC = CaptureVC()
    override func loadViewController() {
        viewController = captureVC
    }
}


class CaptureVC: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationItems()
        setupViews()
    }
    
    func setupNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem!.rx.tap.subscribe(onNext: {
            self.dismiss(animated: true, completion: nil)
        }).addDisposableTo(db)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
        navigationItem.rightBarButtonItem!.rx.tap.subscribe(onNext: {
            self.saveCapturedNote()
            self.dismiss(animated: true, completion: nil)
        }).addDisposableTo(db)
    }
    
    func saveCapturedNote() {
        guard let text = noteTextField.text, text.characters.count > 0 else { return }
        let note = CapturedNote.create()
        RLM.write {
            note.note = text
        }
    }
    
    let stackView = UIStackView(axis: .vertical, spacing: 8, distribution: .fillEqually)
    
    let noteTextField = ItemPropertyTextField.create()
    let urlTextField = ItemPropertyTextField.create()
    
    func setupViews() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        [noteTextField,urlTextField].forEach {
            stackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -260),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
    }
    
    let db = DisposeBag()
}







