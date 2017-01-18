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
        
        let cc = CaptureCoordinator()
        let ccNav = NavigationCoordinator(rootCoordinator: cc)
        
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
        
        
    }
}







