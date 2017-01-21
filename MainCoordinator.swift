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
        let wfcNav = NavigationCoordinator(rootCoordinator: wfc)
        wfcNav.tabBarItem.title = "Waiting For"
        wfcNav.tabBarItem.image = #imageLiteral(resourceName: "workout")
        
        
        let sdmc = SomedayMaybeCoordinator()
        let sdmcNav = NavigationCoordinator(rootCoordinator: sdmc)
        sdmcNav.tabBarItem.title = "Someday/Maybe"
        sdmcNav.tabBarItem.image = #imageLiteral(resourceName: "settings")
        
        let rc = ReferenceCoordinator()
        let rcNav = NavigationCoordinator(rootCoordinator: rc)
        rcNav.tabBarItem.title = "Reference"
        rcNav.tabBarItem.image = #imageLiteral(resourceName: "settings")
        
        let pc = ProjectsCoordinator()
        let pcNav = NavigationCoordinator(rootCoordinator: pc)
        pcNav.tabBarItem.title = "Projects"
        pcNav.tabBarItem.image = #imageLiteral(resourceName: "statistics")
        
        coordinators = [cncNav, nacNav, pcNav, wfcNav, sdmcNav, rcNav,]
        addButton(for: cc, at: 0)
        colorButtons(colorsAndIndices: [(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1),0)])
    }
}
















