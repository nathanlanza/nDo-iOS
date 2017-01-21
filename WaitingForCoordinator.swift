import CoordinatorKit
import UIKit

class WaitingForCoordinator: Coordinator {
    var waitingForTVC: WaitingForTVC { return viewController as! WaitingForTVC }
    override func loadViewController() {
        viewController = WaitingForTVC()
        waitingForTVC.delegate = self
    }
}

extension WaitingForCoordinator: WaitingForTVCDelegate {
    func waitingForTVC(_ waitingForTVC: WaitingForTVC, didSelectItem item: Item) {
        showItemCoordinator(item)
    }
    
    
    func showItemCoordinator(_ item: Item? = nil) {
        let iic = ItemCoordinator(item: item)
        show(iic, sender: self)
    }
}
