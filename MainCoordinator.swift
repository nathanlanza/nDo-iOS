import CoordinatorKit
import RealmSwift
import RxSwift
import RxCocoa
import Reuse

class MainCoordinator: TabBarCoordinator {
    static let main = MainCoordinator()
    
    override func viewControllerDidLoad() {
        super.viewControllerDidLoad()
        
        let ic = ItemsCoordinator()
        let icNav = NavigationCoordinator(rootCoordinator: ic)
        icNav.tabBarItem.title = "Items"
        icNav.tabBarItem.image = #imageLiteral(resourceName: "routine")
        
        let cc = CaptureCoordinator()
        let ccNav = NavigationCoordinator(rootCoordinator: cc)
        ccNav.tabBarItem.image = #imageLiteral(resourceName: "newWorkout")
        ccNav.tabBarItem.title = "Capture"
        
        let cnc = CapturedNotesCoordinator()
        let cncNav = NavigationCoordinator(rootCoordinator: cnc)
        cncNav.tabBarItem.image = #imageLiteral(resourceName: "workout")
        cncNav.tabBarItem.title = "Captured Notes"
        
        coordinators = [icNav, cncNav]
        
        addButton(for: ccNav, at: 1)
    }
}
















