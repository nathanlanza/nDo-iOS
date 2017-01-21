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
    }
}
