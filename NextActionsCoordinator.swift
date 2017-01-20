import CoordinatorKit
import UIKit

class NextActionsCoordinator: Coordinator {
    var nextActionsTVC: NextActionsTVC { return viewController as! NextActionsTVC }
    override func loadViewController() {
        viewController = NextActionsTVC()
        nextActionsTVC.delegate = self
    }
}

extension NextActionsCoordinator: NextActionsTVCDelegate {
    func itemsTVC(_ itemsTVC: ItemsTVC, didSelectItem item: Item) {
        showItemCoordinator(item)
    }
    
    func newItemTapped(for itemsTVC: ItemsTVC) {
        showItemCoordinator()
    }
    
    func showItemCoordinator(_ item: Item? = nil) {
        let iic = ItemCoordinator(item: item)
        show(iic, sender: self)
    }
}
