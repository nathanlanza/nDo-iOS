import CoordinatorKit
import UIKit

class CapturedNotesCoordinator: Coordinator {
    let capturedNotesTVC = CapturedNotesTVC()
    override func loadViewController() {
        viewController = capturedNotesTVC
    }
}
