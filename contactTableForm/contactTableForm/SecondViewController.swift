
import UIKit

class SecondViewController: UIViewController {

    var contact: Contacts?
    
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let cont = contact else{return}
        NameLabel.text = "Name: \(cont.name ?? "")"
        phoneLabel.text = "PhoneNumber: \(cont.moobaile ?? 0)"
        addressLabel.text = "Address: \(cont.address ?? "")"
        companyLabel.text = "Company: \(cont.company ?? "")"
    
    }
}

    
