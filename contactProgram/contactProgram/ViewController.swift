//
//  ViewController.swift
//  contactProgram
//
//  Created by ahmad alkhateeb on 14/10/2021.
//

import UIKit

struct Contact{
    var name: String = ""
    var phone:Int = 0
    var address: String = ""
    var company: String = ""
}

class ViewController: UIViewController {

    struct ContactGroup{
        var alpha: String = ""
        var contacts: [Contact] = []
    }
    
    var arrayList: [ContactGroup] = []{
        didSet {
            tableView.reloadData()
        }
    }
    var selected :Contact?
    
    @IBOutlet weak var tableView: UITableView!
    
   
    let contacts = [
        Contact(name: "ahmad", phone: 0797504043, address: "amman", company: "Gistec"),
        Contact(name: "mais", phone: 0797504043, address: "amman", company: "Gistec"),
        Contact(name: "basem", phone: 0797504043, address: "amman", company: "Gistec"),
        Contact(name: "mohammed", phone: 0797504043, address: "amman", company: "Gistec"),
        Contact(name: "yaseer", phone: 0797504043, address: "dsasd", company: "Gistec"),
        Contact(name: "duha", phone: 0797504043, address: "amman", company: "Gistec")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrayList = groupingArray(array : contacts)
    }
   
    
    func groupingArray(array : [Contact]) ->[ContactGroup]{
        var groupcontact:[ContactGroup] = []
        
        for name in contacts{
            guard let first =  name.name.first?.lowercased() else {return []}
            if (groupcontact.contains{ ContactGroup in
                    return String(first) == ContactGroup.alpha}){
                
                guard let index = (groupcontact.firstIndex(where: { ContactGroup in
                    return String(first) == ContactGroup.alpha
                })) else {return []}
                groupcontact[index].contacts.append(name)
            }
            
            else{
                groupcontact.append(ContactGroup(alpha: String(first), contacts: [name]))
            }
            
        }
        groupcontact.sort {$0.alpha < $1.alpha}
        return groupcontact
    }

}
extension ViewController:UITableViewDataSource , UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        arrayList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayList[section].contacts.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = arrayList[indexPath.section].contacts[indexPath.row]
        performSegue(withIdentifier: "toContact", sender: self)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Contacts", for: indexPath) as! Contacts
        
        cell.contactLabel.text = arrayList[indexPath.section].contacts[indexPath.row].name

        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerLabel = UILabel()
        headerLabel.text = arrayList[section].alpha
        headerLabel.backgroundColor = .red
        headerLabel.font = UIFont.systemFont(ofSize: 25)
        headerLabel.textColor = .blue
        return headerLabel
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toContact"){
            if let vc = segue.destination as? contactInfo {
                guard let newcontact = selected else{return}
                vc.contacts = newcontact
            }
        }
    }
}

