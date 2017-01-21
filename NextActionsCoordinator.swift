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
    func nextActionsTVC(_ nextActionsTVC: NextActionsTVC, didSelectItem item: Item) {
        showItemCoordinator(item)
    }
    
    
    func showItemCoordinator(_ item: Item) {
        let iic = ItemCoordinator(item: item)
        show(iic, sender: self)
    }
}
