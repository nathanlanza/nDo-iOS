import UIKit
import RxSwift
import RxCocoa

class ItemVC: UIViewController {
    
    var item: Item! {
        didSet {
            detailTextField.placeholder = item.detail
            firstStepTextField.placeholder = item.firstStep
            finishedConditionTextField.placeholder = item.finishedCondition
        }
    }
    
    let stackView = UIStackView(axis: .vertical, spacing: 8, distribution: .fillEqually)
    
    let detailTextField = ItemPropertyTextField.create()
    let firstStepTextField = ItemPropertyTextField.create()
    let finishedConditionTextField = ItemPropertyTextField.create()
    
    func setupViews() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        [detailTextField,firstStepTextField,finishedConditionTextField].forEach {
            stackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -260),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupViews()
        setupRx()
    }
    
    func setupRx() {
        detailTextField.rx.controlEvent(.editingDidEnd).subscribe(onNext: {
            RLM.write {
                self.item.detail = self.detailTextField.text ?? ""
            }
        }).addDisposableTo(db)
        firstStepTextField.rx.controlEvent(.editingDidEnd).subscribe(onNext: {
            RLM.write {
                self.item.firstStep = self.firstStepTextField.text ?? ""
            }
        }).addDisposableTo(db)
        finishedConditionTextField.rx.controlEvent(.editingDidEnd).subscribe(onNext: {
            RLM.write {
                self.item.finishedCondition = self.finishedConditionTextField.text ?? ""
            }
        }).addDisposableTo(db)
    }
    let db = DisposeBag()
}
