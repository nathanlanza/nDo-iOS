import CoordinatorKit
import UIKit

class CaptureCoordinator: Coordinator {
    let captureVC = CaptureVC()
    override func loadViewController() {
        viewController = captureVC
    }
}

extension CaptureCoordinator: TabBarButtonCoordinator {
    func prepareForReuse() {
        captureVC.item = nil
        captureVC.noteTextField.text = nil
        captureVC.noteTextField.placeholder = "Capture note here."
        captureVC.urlTextField.text = nil
        captureVC.urlTextField.placeholder = "Capture a URL here."
    }
}
