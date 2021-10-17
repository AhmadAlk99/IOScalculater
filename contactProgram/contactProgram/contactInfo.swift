

import UIKit

class contactInfo: UIViewController {

    var contacts:Contact?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var phneNumber: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var companyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let cont = contacts else{return}
        nameLabel.text = "Name: \(cont.name) "
        phneNumber.text = "PhoneNumber: \(cont.phone) "
        addressLabel.text = "Address: \(cont.address) "
        companyLabel.text = "Company: \(cont.company) "
    }
    

   

}
