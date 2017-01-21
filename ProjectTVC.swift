import UIKit
import RxSwift
import RxCocoa
import RealmSwift
import RxRealm
import Reuse

protocol ProjectsTVCDelegate: class {
    func projectsTVC(_ projectsTVC: ProjectsTVC, didSelectProject project: Project)
}

class ProjectsTVC: UIViewController {
    
    weak var delegate: ProjectsTVCDelegate!
    
    let projects = RLM.objects(Project.self)
    
    let tableView = UITableView()
    override func loadView() {
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupNavBar()
        setupTableView()
    }
    
    func setupNavBar() {
        let r = UIBarButtonItem(title: "New", style: .plain)
        r.rx.tap.subscribe(onNext: {
            self.presentAddProjectAlertController()
        }).addDisposableTo(db)
        navigationItem.rightBarButtonItem = r
    }
    
    func presentAddProjectAlertController() {
        let ac = UIAlertController(title: "Add New Project", message: "What should it be called?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { _ in
            let tf = ac.textFields!.first!
            let project = Project.create()
            RLM.write {
                project.title = tf.text!
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        ac.addAction(ok)
        ac.addAction(cancel)
        ac.addTextField(configurationHandler: nil)
        present(ac, animated: true)
    }
    
    
    func setupTableView() {
        tableView.register(UITableViewCell.self)
        Observable.from(projects).bindTo(tableView.rx.items(cellIdentifier: UITableViewCell.reuseIdentifier, cellType: UITableViewCell.self)) { index, project, cell in
            cell.textLabel?.text = project.title
            cell.detailTextLabel?.text = project.detail
            }.addDisposableTo(db)
        
        tableView.rx.modelSelected(Item.self).subscribe(onNext: { item in
            self.delegate.projectsTVC(self, didSelectItem: item)
        }).addDisposableTo(db)
        
        tableView.rx.itemDeleted.subscribe(onNext: { indexPath in
            let removed = self.projects[indexPath.row]
            removed.delete()
        }).addDisposableTo(db)
    }
    
    let db = DisposeBag()
}


