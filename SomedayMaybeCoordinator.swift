import CoordinatorKit
import UIKit

class SomedayMaybeCoordinator: Coordinator {
    var somedayMaybeTVC: SomedayMaybeTVC { return viewController as! SomedayMaybeTVC }
    override func loadViewController() {
        viewController = SomedayMaybeTVC()
        somedayMaybeTVC.delegate = self
    }
}

extension SomedayMaybeCoordinator: SomedayMaybeTVCDelegate {
    func somedayMaybeTVC(_ somedayMaybeTVC: SomedayMaybeTVC, didSelectItem item: Item) {
        showItemCoordinator(item)
    }
    
    
    func showItemCoordinator(_ item: Item? = nil) {
        let iic = ItemCoordinator(item: item)
        show(iic, sender: self)
    }
}
