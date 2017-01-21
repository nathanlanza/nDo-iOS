import UIKit
import CoordinatorKit

class ItemCoordinator: Coordinator {
    
    let item: Item
    
    init(item: Item? = nil) {
        self.item = item ?? Item.create()
        super.init()
    }
    
    var itemVC: ItemVC { return viewController as! ItemVC }
    override func loadViewController() {
        viewController = ItemVC(item: item)
    }
}
