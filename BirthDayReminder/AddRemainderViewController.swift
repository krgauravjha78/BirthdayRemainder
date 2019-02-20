//
//  AddRemainderViewController.swift
//  BirthDayReminder
//
//  Created by iWizards XI on 15/02/19.
//  Copyright © 2019 iWizards XI. All rights reserved.
//

import UIKit
import RealmSwift

class AddRemainderViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
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
    var gradePicker: UIPickerView!
    
    //MARK: Variables
    var celebrationArr = [String: String]()
    var contactArr : Results<Contact_Tbl>!
    let pickerValues = ["Birthday", "Anniversary", "Promotion"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        txtDate.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControl.Event.valueChanged)
        
        gradePicker = UIPickerView()
        gradePicker.dataSource = self
        gradePicker.delegate = self
        txtOccassion.inputView = gradePicker
        txtOccassion.text = pickerValues[0]
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
    
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        txtDate.text = dateFormatter.string(from: sender.date)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return pickerValues.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtOccassion.text = pickerValues[row]
        self.view.endEditing(true)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerValues[row]
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
