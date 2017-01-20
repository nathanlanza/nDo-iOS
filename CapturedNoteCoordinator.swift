import UIKit
import CoordinatorKit

class ItemCoordinator: Coordinator {
    var captureVC: CaptureVC { return viewController as! CaptureVC }

    init(item: Item) {
        self.item = item
        super.init()
    }
    
    let item: Item
    
    override func loadViewController() {
        viewController = CaptureVC(item: item)
    }
}
