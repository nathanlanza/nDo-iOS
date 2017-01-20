import CoordinatorKit
import RealmSwift
import RxSwift
import RxCocoa
import Reuse

class MainCoordinator: TabBarCoordinator {
    static let main = MainCoordinator()
    
    override func viewControllerDidLoad() {
        super.viewControllerDidLoad()
        
        let cc = CaptureCoordinator()
        cc.tabBarItem.title = "Capture"
        cc.tabBarItem.image = #imageLiteral(resourceName: "newWorkout")
        
        let cnc = CapturedNotesCoordinator()
        let cncNav = NavigationCoordinator(rootCoordinator: cnc)
        cncNav.tabBarItem.image = #imageLiteral(resourceName: "workout")
        cncNav.tabBarItem.title = "In"
       
        let ic = ItemsCoordinator()
        let icNav = NavigationCoordinator(rootCoordinator: ic)
        icNav.tabBarItem.title = "Next Actions"
        icNav.tabBarItem.image = #imageLiteral(resourceName: "routine")
        
        coordinators = [cncNav, icNav]
        addButton(for: cc, at: 0)
        colorButtons(colorsAndIndices: [(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1),0)])
    }
}
















