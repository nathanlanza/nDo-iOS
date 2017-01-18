import CoordinatorKit
import RealmSwift
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













