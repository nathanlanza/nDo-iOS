import CoordinatorKit
import UIKit

class CapturedNotesCoordinator: Coordinator {
    let capturedNotesTVC = CapturedNotesTVC()
    override func loadViewController() {
        viewController = capturedNotesTVC
        capturedNotesTVC.delegate = self
    }
}


extension CapturedNotesCoordinator: CapturedNotesTVCDelegate {
    func capturedNotesTVC(_ capturedNotesTVC: CapturedNotesTVC, didSelectCapturedNote capturedNote: CapturedNote) {
        let cnc = CapturedNoteCoordinator(capturedNote: capturedNote)
        show(cnc, sender: self)
    }
}
