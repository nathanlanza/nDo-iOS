import UIKit
import CoordinatorKit

class ItemCoordinator: Coordinator {
    
    let item: Item
    
    init(item: Item) {
        self.item = item
        super.init()
    }
    
    var itemVC: ItemVC { return viewController as! ItemVC }
    override func loadViewController() {
        viewController = ItemVC(item: item)
        itemVC.delegate = self
    }
}

extension ItemCoordinator: ItemVCDelegate {
    func projectsSelected() {
        let psc = ProjectSelectionCoordinator(item: item)
        show(psc, sender: self)
    }
}

class ProjectSelectionCoordinator: Coordinator {
    let item: Item
    
    init(item: Item) {
        self.item = item
        super.init()
    }
    
    var projectSelectionTVC: ProjectSelectionTVC { return viewController as! ProjectSelectionTVC }
    override func loadViewController() {
        viewController = ProjectSelectionTVC(item: item)
    }
}
