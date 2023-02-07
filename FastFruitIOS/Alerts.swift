import Foundation
import UIKit

//class Alerts: MapViewController {
class Alerts: UIViewController {
    
    func message(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
}
