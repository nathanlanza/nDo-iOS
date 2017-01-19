import UIKit
import CoordinatorKit

class CapturedNoteCoordinator: Coordinator {
    var captureVC: CaptureVC { return viewController as! CaptureVC }

    init(capturedNote: CapturedNote) {
        self.capturedNote = capturedNote
        super.init()
    }
    
    let capturedNote: CapturedNote
    
    override func loadViewController() {
        viewController = CaptureVC(capturedNote: capturedNote)
    }
}
