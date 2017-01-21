import UIKit
import RxSwift
import RxCocoa
import RealmSwift
import RxRealm
import Reuse

protocol ProjectSelectionTVCDelegate: class {
    func projectSelectionTVC(_ projectSelectionTVC: ProjectSelectionTVC, didSelectProject project: Project)
    func finishedSelection()
}

class ProjectSelectionTVC: UIViewController {
    init(item: Item) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    weak var delegate: ProjectSelectionTVCDelegate!
    
    let item: Item
    let projects = RLM.objects(Project.self)
    
    let tableView = UITableView()
    override func loadView() {
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    
    func setupTableView() {
        tableView.register(UITableViewCell.self)
        Observable.from(projects).bindTo(tableView.rx.items(cellIdentifier: UITableViewCell.reuseIdentifier, cellType: UITableViewCell.self)) { index, project, cell in
            cell.textLabel?.text = project.title
            cell.detailTextLabel?.text = project.detail
            }.addDisposableTo(db)
        
        tableView.rx.modelSelected(Project.self).subscribe(onNext: { project in
            RLM.write {
                self.item.project = project
            }
            self.delegate.finishedSelection()
        }).addDisposableTo(db)
        
        tableView.rx.itemDeleted.subscribe(onNext: { indexPath in
            let removed = self.projects[indexPath.row]
            removed.delete()
        }).addDisposableTo(db)
    }
    
    let db = DisposeBag()
}



