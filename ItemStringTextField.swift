import UIKit
import Reuse

class ItemPropertyTextField: UITextField {
    static func create() -> ItemPropertyTextField {
        let iptf = ItemPropertyTextField()
        iptf.setBorder(color: .cyan, width: 1, radius: 12)
        return iptf
    }
}
