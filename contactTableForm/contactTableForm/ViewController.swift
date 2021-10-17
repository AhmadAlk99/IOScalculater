//
//  ViewController.swift
//  contactTableForm
//
//  Created by ahmad alkhateeb on 13/10/2021.
//

import UIKit

struct Contacts {
    
    var name: String? = ""
    var moobaile: Int? = 0
    var address: String? = ""
    var company: String? = ""
}

class ViewController: UIViewController {
    
    struct ContactsGroup {
        
        var alpha: String = ""
        var contacts: [Contacts] = []
    }
    
    @IBOutlet weak var TableView: UITableView!
    
    
    let contacts = [
        Contacts(name: "ahmad", moobaile: 0, address: "amman", company: "Gistec"),
        Contacts(name: "mais", moobaile: 0, address: "amman", company: "Gistec"),
        Contacts(name: "basem", moobaile: 0, address: "amman", company: "Gistec"),
        Contacts(name: "mohammed", moobaile: 0, address: "amman", company: "Gistec"),
        Contacts(name: "yaseer", moobaile: 0, address: "dsasd", company: "Gistec"),
        Contacts(name: "duha", moobaile: 0, address: "amman", company: "Gistec")
    ]
    
    var selectedContact: Contacts?
    
    var finalList:[ContactsGroup] = []{
        didSet {
            
            TableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        finalList = groupingArray(array: contacts)
    }

    func groupingArray(array : [Contacts]) -> [ContactsGroup] {
        
        var localList: [ContactsGroup] = []
        for contact in contacts{
            guard let first = contact.name?.first?.lowercased() else {return []}
            if(localList.contains{ ContactsGroup in
                return String(first) == ContactsGroup.alpha
            }){
                guard let index = (localList.firstIndex{ ContactsGroup in
                    return String(first) == ContactsGroup.alpha
                }) else {return []}
                
                localList[index].contacts.append(contact)
                
            } else {
                localList.append(ContactsGroup(alpha: String(first), contacts: [contact]))
            }
            
        }
        localList.sort { $0.alpha < $1.alpha}
        
        return localList
    }

    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        finalList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        finalList[section].contacts.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedContact = finalList[indexPath.section].contacts[indexPath.row]
        performSegue(withIdentifier: "SegueContactViewer", sender: self)
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "Cells", for: indexPath) as! Cells
        cell.CellLabel.text = finalList[indexPath.section].contacts[indexPath.row].name
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerLabel = UILabel()
        headerLabel.backgroundColor = .lightGray
        headerLabel.textColor = .black
        headerLabel.font = UIFont.systemFont(ofSize: 25)
        headerLabel.text = "   \(finalList[section].alpha)"
        
        return headerLabel
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueContactViewer" {
            if let vc = segue.destination as? SecondViewController {
                guard let contactnew = selectedContact else {return}
                    vc.contact = contactnew
            }
        }
    }
}


