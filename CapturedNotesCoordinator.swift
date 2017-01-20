import CoordinatorKit
import UIKit

class InCoordinator: Coordinator {
    let inTVC = InTVC()
    override func loadViewController() {
        viewController = inTVC
        inTVC.delegate = self
    }
}


extension InCoordinator: InTVCDelegate {
    func inTVC(_ inTVC: InTVC, didSelectItem item: Item) {
        let ic = ItemCoordinator(item: item)
        show(ic, sender: self)
    }
}
