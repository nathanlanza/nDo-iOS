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
        
        let cnc = InCoordinator()
        let cncNav = NavigationCoordinator(rootCoordinator: cnc)
        cncNav.tabBarItem.image = #imageLiteral(resourceName: "workout")
        cncNav.tabBarItem.title = "In"
       
        let nac = NextActionsCoordinator()
        let nacNav = NavigationCoordinator(rootCoordinator: nac)
        nacNav.tabBarItem.title = "Next Actions"
        nacNav.tabBarItem.image = #imageLiteral(resourceName: "routine")
        
        let wfc = WaitingForCoordinator() 
        wfc.tabBarItem.title = "Waiting For"
        wfc.tabBarItem.image = #imageLiteral(resourceName: "workout")
        
        let pc = Coordinator()
        pc.tabBarItem.title = "Projects"
        pc.tabBarItem.image = #imageLiteral(resourceName: "statistics")
        
        let sdmc = SomedayMaybeCoordinator()
        sdmc.tabBarItem.title = "Someday/Maybe"
        sdmc.tabBarItem.image = #imageLiteral(resourceName: "settings")
        
        let rc = ReferenceCoordinator()
        rc.tabBarItem.title = "Reference"
        rc.tabBarItem.image = #imageLiteral(resourceName: "settings")
        
        
        coordinators = [cncNav, nacNav, wfc, pc, sdmc, rc]
        addButton(for: cc, at: 0)
        colorButtons(colorsAndIndices: [(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1),0)])
    }
}
















