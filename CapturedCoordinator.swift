import UIKit
import CoordinatorKit

class CapturedItemCoordinator: Coordinator {
    var itemVC: ItemVC { return viewController as! ItemVC }

    init(item: Item) {
        self.item = item
        super.init()
    }
    
    let item: Item
    
    override func loadViewController() {
        viewController = CaptureVC()
    }
}
