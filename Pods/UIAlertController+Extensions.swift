//import UIKit
//
//class UIAlertControllerConfigurer {
//    var title: String?
//    var message: String?
//    
//    let ac = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
//    var action: UIAlertAction?
//    
//    static func createAlert(title: String) -> UIAlertControllerConfigurer {
//        let a = UIAlertControllerConfigurer()
//        a.ac.title = title
//        return a
//    }
//    func addMessage(message: String) -> UIAlertControllerConfigurer {
//        ac.message = message
//        return self
//    }
//    func createAction(title: String, style: UIAlertActionStyle) -> UIAlertControllerConfigurer {
//        action = UIAlertAction(title: title, style: style, handler: nil)
//        return self
//    }
//    func addHandlerToAction(handler: @escaping ((UIAlertAction) -> Void)) -> UIAlertControllerConfigurer {
//        action = UIAlertAction(title: action!.title, style: action!.style, handler: handler)
//        return self
//    }
//    func addAction() -> UIAlertControllerConfigurer {
//        ac.addAction(action!)
//        action = nil
//        return self
//    }
//    func add(completionHandler: ((Void) -> Void)) -> UIAlertControllerConfigurer {
//        ac.
//    }
//}
