import UIKit
import RxSwift
import RxCocoa

class ItemVC: UIViewController {
    
    var item: Item! {
        didSet {
            detailTextField.text = item.detail
            firstStepTextField.text = item.firstStep
            finishedConditionTextField.text = item.finishedCondition
        }
    }
    
    let stackView = UIStackView(axis: .vertical, spacing: 8, distribution: .fillEqually)
    
    let detailTextField = UITextField()
    let firstStepTextField = UITextField()
    let finishedConditionTextField = UITextField()
    
    func setupViews() {
        [detailTextField,firstStepTextField,finishedConditionTextField].forEach {
            stackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupRx()
    }
    
    func setupRx() {
        detailTextField.rx.controlEvent(.editingDidEnd).subscribe(onNext: {
            self.item.detail = self.detailTextField.text ?? ""
        }).addDisposableTo(db)
        firstStepTextField.rx.controlEvent(.editingDidEnd).subscribe(onNext: {
            self.item.firstStep = self.firstStepTextField.text ?? ""
        }).addDisposableTo(db)
        finishedConditionTextField.rx.controlEvent(.editingDidEnd).subscribe(onNext: {
            self.item.finishedCondition = self.finishedConditionTextField.text ?? ""
        }).addDisposableTo(db)
    }
    let db = DisposeBag()
}
