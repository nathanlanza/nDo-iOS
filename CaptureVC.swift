import UIKit
import RxSwift
import RxCocoa

class CaptureVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupViews()
        setupNavigationItems()
        setupRx()
    }
    
    func setupRx() {
    }
    
    func setupNavigationItems() {
        let l = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
        l.rx.tap.subscribe(onNext: {
            self.dismiss(animated: true, completion: nil)
        }).addDisposableTo(db)
        navigationItem.leftBarButtonItem = l
        
        let r = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
        r.rx.tap.subscribe(onNext: {
            self.saveItem()
            self.dismiss(animated: true, completion: nil)
        }).addDisposableTo(db)
        navigationItem.rightBarButtonItem = r
    }
    
    func saveItem() {
        guard let text = detailTextField.text, text.characters.count > 0 else { return }
        let note = Item.create()
        RLM.write {
            note.detail = text
        }
    }
    
    let stackView = UIStackView(axis: .vertical, spacing: 8, distribution: .fillEqually)
    
    let detailTextField = ItemPropertyTextField.create()
    let linkTextField = ItemPropertyTextField.create()
    
    func setupViews() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        [detailTextField,linkTextField].forEach {
            stackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -260),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
    }
    
    let db = DisposeBag()
}
