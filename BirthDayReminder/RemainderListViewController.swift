//
//  RemainderListViewController.swift
//  BirthDayReminder
//
//  Created by iWizards XI on 15/02/19.
//  Copyright © 2019 iWizards XI. All rights reserved.
//

import UIKit
import RealmSwift

class RemainderListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchRemainder: UISearchBar!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet var tblRemainderList: UITableView!
    
    var arrRemainder: Results<Remainder_Tbl>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchRemainder.backgroundImage = UIImage()
        arrRemainder = RealmFunctionsForRemainderTable.sharedInstance.QueryDataFromRemainderTable()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arrRemainder.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RemainderList")as! RemainderTableCell
        
        if arrRemainder.count == 0{
            
        }
        else{
            cell.lblFName.text = arrRemainder[indexPath.row].FirstName
            cell.lblLName.text = arrRemainder[indexPath.row].LastName
            cell.lblEmail.text = arrRemainder[indexPath.row].EmailId
            cell.lblBirthDate.text = arrRemainder[indexPath.row].Date
            
            let Occassion = arrRemainder[indexPath.row].Occasion
            
            if Occassion == "Birthday"  {
                cell.imgOccasion.image = #imageLiteral(resourceName: "BirthDay")
            }else{
                cell.imgOccasion.image = #imageLiteral(resourceName: "Anniversary")
            }
            
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    }
    

    // MARK: - Button Action
    @IBAction func btnAddRemainderClicked(_ sender: Any) {
        performSegue(withIdentifier: "AddRemainder", sender: self)
    }
    
    // MARK: - UnWind Method
    @IBAction func unwindtoRemainderlist(segue:UIStoryboardSegue) {
        arrRemainder = RealmFunctionsForRemainderTable.sharedInstance.QueryDataFromRemainderTable()
        self.tblRemainderList.reloadData()
    }
    
}

class RemainderTableCell : UITableViewCell {
    @IBOutlet weak var lblFName: UILabel!
    @IBOutlet weak var lblLName: UILabel!
    @IBOutlet weak var lblBirthDate: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet var seperatorView: UIView!
    @IBOutlet weak var imgOccasion: UIImageView!
    
}
