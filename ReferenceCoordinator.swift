import CoordinatorKit
import UIKit

class ReferenceCoordinator: Coordinator {
    var referenceTVC: ReferenceTVC { return viewController as! ReferenceTVC }
    override func loadViewController() {
        viewController = ReferenceTVC()
        referenceTVC.delegate = self
    }
}

extension ReferenceCoordinator: ReferenceTVCDelegate {
    func referenceTVC(_ referenceTVC: ReferenceTVC, didSelectItem item: Item) {
        showItemCoordinator(item)
    }
    
    
    func showItemCoordinator(_ item: Item? = nil) {
        let iic = ItemCoordinator(item: item)
        show(iic, sender: self)
    }
}
