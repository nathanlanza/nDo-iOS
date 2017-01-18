import UIKit
import CoordinatorKit

class ItemCoordinator: Coordinator {
    
    let item: Item
    
    init(item: Item? = nil) {
        self.item = item ?? Item.create()
        super.init()
    }
    
    let itemVC = ItemVC()
    override func loadViewController() {
        viewController = itemVC
        itemVC.item = item
    }
}
