import CoordinatorKit
import UIKit

class ProjectsCoordinator: Coordinator {
    var projectsTVC: ProjectsTVC { return viewController as! ProjectsTVC }
    override func loadViewController() {
        viewController = ProjectsTVC()
        projectsTVC.delegate = self
    }
}

extension ProjectsCoordinator: ProjectsTVCDelegate {
    func projectsTVC(_ projectsTVC: ProjectsTVC, didSelectProject project: Project) {
        print("Can't do dis yet")
    }
    
    
    func showItemCoordinator(_ item: Item? = nil) {
        let iic = ItemCoordinator(item: item)
        show(iic, sender: self)
    }
}
