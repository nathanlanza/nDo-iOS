

class ItemsCoordinator: Coordinator {
    var itemsTVC: ItemsTVC { return viewController as! ItemsTVC }
    override func loadViewController() {
        viewController = ItemsTVC()
        itemsTVC.delegate = self
    }
}

extension ItemsCoordinator: ItemsTVCDelegate {
    func itemsTVC(_ itemsTVC: ItemsTVC, didSelectItem item: Item) {
        let iic = ItemCoordinator(item: item)
        show(iic, sender: self)
    }
}
