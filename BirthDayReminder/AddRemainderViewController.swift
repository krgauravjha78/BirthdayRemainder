//
//  AddRemainderViewController.swift
//  BirthDayReminder
//
//  Created by iWizards XI on 15/02/19.
//  Copyright © 2019 iWizards XI. All rights reserved.
//

import UIKit
import RealmSwift

class AddRemainderViewController: UIViewController {
    
    
    //MARK: Outlets
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var btnDone: UIButton!
    @IBOutlet var btnOpenContact: UIButton!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var lblFname: UILabel!
    @IBOutlet var lblLname: UILabel!
    @IBOutlet var lblEmail: UILabel!
    @IBOutlet var lblOccassion: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var txtFname: UITextField!
    @IBOutlet var txtLname: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtOccassion: UITextField!
    @IBOutlet var txtDate: UITextField!
    
    //MARK: Variables
    var celebrationArr = [String: String]()
    var contactArr : Results<Contact_Tbl>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func generateRowID() -> String {
        let rowid =  UUID().uuidString
        let rowidc = rowid.index(rowid.startIndex, offsetBy: 6)
        let finalid = rowid[..<rowidc]
        return "IN_"+String(finalid)
    }
    
    
    // MARK: - Button Action
    @IBAction func btnBackClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnDoneClicked(_ sender: Any) {
        
        celebrationArr["CreatedDate"] = txtDate.text
        celebrationArr["FirstName"] = txtFname.text
        celebrationArr["LastName"] = txtLname.text
        celebrationArr["Occasion"] = txtOccassion.text
        celebrationArr["Email"] = txtEmail.text
        celebrationArr["Comment"] = ""
        celebrationArr["ID"] = generateRowID()
        
        let myArray = [celebrationArr]
        
        RealmFunctionsForRemainderTable.sharedInstance.InsertDataIntoRemainderTable(remainderDataArray: myArray)
        
        self.performSegue(withIdentifier: "UWtoRemainderList", sender: self)
    }

    @IBAction func btnOpenConatactClicked(_ sender: Any) {
        performSegue(withIdentifier: "OpenContactList", sender: self)
    }
    
    
    // MARK: - UnWind Method
    @IBAction func unwindtoAddRemainderViewController(segue:UIStoryboardSegue) {
        
        let selectedId = UserDefaults.standard.value(forKey: "SelectedId")
        contactArr = RealmFunctionsForContactTable.sharedInstance.QueryDataFromContactTableForId(id: selectedId as! String )
        txtFname.text = contactArr[0].FirstName
        txtLname.text = contactArr[0].LastName
        txtEmail.text = contactArr[0].EmailId
        
        UserDefaults.standard.removeObject(forKey: "SelectedId")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
