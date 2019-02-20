//
//  ContactListViewController.swift
//  BirthDayReminder
//
//  Created by iWizards XI on 19/02/19.
//  Copyright © 2019 iWizards XI. All rights reserved.
//

import UIKit
import Contacts
import RealmSwift

class ContactListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var tblContactList: UITableView!
    var objects = [CNContact]()
    

    //MARK: Variables
    var contactArr = [String: String]()
    var arrContact: Results<Contact_Tbl>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       self.fetchContact()
        arrContact = RealmFunctionsForContactTable.sharedInstance.QueryDataFromContactTable()
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactList")as! ContactTableCell
        
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 20
        
        if arrContact.count == 0{
            
        }
        else{
            cell.lblFName.text = arrContact[indexPath.section].FirstName
            cell.lblLName.text = arrContact[indexPath.section].LastName
            cell.imgContact.image = #imageLiteral(resourceName: "User")
            
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if arrContact.count == 0{
            
        }
        else{
            let Id = arrContact[indexPath.section].Id
            UserDefaults.standard.setValue(Id, forKey: "SelectedId")
            self.performSegue(withIdentifier: "UWtoAddRemainder", sender: self)
            
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrContact.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView;
    }
    
    
    func generateRowID() -> String {
        let rowid =  UUID().uuidString
        let rowidc = rowid.index(rowid.startIndex, offsetBy: 6)
        let finalid = rowid[..<rowidc]
        return "GA_"+String(finalid)
    }
    
    
    func fetchContact() {
        print("Attempt to fetch contact")
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, err) in
            if let err = err{
                print("Failed to fetch Contact", err)
                return
            }
            if granted{
                print("Access Granted")
                
//                let keys = [CNContactGivenNameKey]
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactEmailAddressesKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])

                do {
                  try store.enumerateContacts(with: request, usingBlock: { (contact, stopEnumerating) in
                        print(contact.givenName)
                        print(contact.familyName)
                        print(contact.phoneNumbers.first?.value.stringValue ?? "")
                        print(contact.emailAddresses.first?.value ?? "")
                    
                    self.contactArr["Contact"] = contact.phoneNumbers.first?.value.stringValue ?? ""
                    self.contactArr["FirstName"] = contact.givenName
                    self.contactArr["LastName"] = contact.familyName
                    self.contactArr["EmailId"] = contact.emailAddresses.first?.value as String?
                    self.contactArr["Id"] = self.generateRowID()
                    
                    let myArray = [self.contactArr]
                    RealmFunctionsForContactTable.sharedInstance.InsertDataIntoContactTable(contactDataArray: myArray)
                    
                    })
                    
                } catch let err{
                    print("Failed To Enumarate contact:" , err)
                }
                
            } else{
                print("Access Denied")
            }
        }
        
    }
    
    // MARK: - Button Action
    @IBAction func btnBackClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    

}

class ContactTableCell : UITableViewCell {
    
    @IBOutlet weak var lblFName: UILabel!
    @IBOutlet weak var lblLName: UILabel!
    @IBOutlet var seperatorView: UIView!
    @IBOutlet weak var imgContact: UIImageView!
    
}
