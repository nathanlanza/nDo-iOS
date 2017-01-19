import UIKit
import RxSwift
import RxCocoa
import RealmSwift

protocol CapturedNotesTVCDelegate: class {
    func capturedNotesTVC(_ capturedNotesTVC: CapturedNotesTVC, didSelectCapturedNote note: CapturedNote)
}

class CapturedNotesTVC: UIViewController {
    
    weak var delegate: CapturedNotesTVCDelegate!
    
    let tableView = UITableView()
    override func loadView() {
        view = tableView
    }
    
    var capturedNotes: Results<CapturedNote>! {
        didSet {
            variable.value = Array(capturedNotes)
        }
    }
    let variable = Variable([CapturedNote]())
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        capturedNotes = RLM.objects(CapturedNote.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        
        tableView.register(UITableViewCell.self)
        variable.asObservable().bindTo(tableView.rx.items(cellIdentifier: UITableViewCell.reuseIdentifier, cellType: UITableViewCell.self)) { index, value, cell in
            cell.textLabel?.text = value.note
            }.addDisposableTo(db)
        
        tableView.rx.modelSelected(CapturedNote.self).subscribe(onNext: { capturedNote in
            self.delegate.capturedNotesTVC(self, didSelectCapturedNote: capturedNote)
        }).addDisposableTo(db)
        
        tableView.rx.itemDeleted.subscribe(onNext: { indexPath in
            let removed = self.variable.value.remove(at: indexPath.row)
            removed.delete()
        }).addDisposableTo(db)
        
    }
    
    let db = DisposeBag()
}
