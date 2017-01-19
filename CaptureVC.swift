import UIKit
import RxSwift
import RxCocoa

class CaptureVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationItems()
        setupViews()
    }
    
    func setupNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem!.rx.tap.subscribe(onNext: {
            self.dismiss(animated: true, completion: nil)
        }).addDisposableTo(db)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
        navigationItem.rightBarButtonItem!.rx.tap.subscribe(onNext: {
            self.saveCapturedNote()
            self.dismiss(animated: true, completion: nil)
        }).addDisposableTo(db)
    }
    
    func saveCapturedNote() {
        guard let text = noteTextField.text, text.characters.count > 0 else { return }
        let note = CapturedNote.create()
        RLM.write {
            note.note = text
        }
    }
    
    let stackView = UIStackView(axis: .vertical, spacing: 8, distribution: .fillEqually)
    
    let noteTextField = ItemPropertyTextField.create()
    let urlTextField = ItemPropertyTextField.create()
    
    func setupViews() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        [noteTextField,urlTextField].forEach {
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
