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
            return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RemainderList")as! RemainderTableCell
        
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 25
        
        if arrRemainder.count == 0{
            
        }
        else{
            cell.lblFName.text = arrRemainder[indexPath.section].FirstName
            cell.lblLName.text = arrRemainder[indexPath.section].LastName
            cell.lblEmail.text = arrRemainder[indexPath.section].EmailId
            cell.lblBirthDate.text = arrRemainder[indexPath.section].Date
            
            let Occassion = arrRemainder[indexPath.section].Occasion
            
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrRemainder.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView;
    }
    
    
    

    // MARK: - Button Action
    @IBAction func btnAddRemainderClicked(_ sender: Any) {
        performSegue(withIdentifier: "AddRemainder", sender: self)
    }
    
    @IBAction func btnRefreshClicked(_ sender: Any) {
        searchRemainder.text = ""
        arrRemainder = RealmFunctionsForRemainderTable.sharedInstance.QueryDataFromRemainderTable()
        self.tblRemainderList.reloadData()
    }
    
    
    // MARK: - UnWind Method
    @IBAction func unwindtoRemainderlist(segue:UIStoryboardSegue) {
        searchRemainder.text = ""
        arrRemainder = RealmFunctionsForRemainderTable.sharedInstance.QueryDataFromRemainderTable()
        self.tblRemainderList.reloadData()
    }
    
    // MARK: - SearchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.count == 0{
                arrRemainder = RealmFunctionsForRemainderTable.sharedInstance.QueryDataFromRemainderTable()
            }
            else{
                let predicate = NSPredicate (format: "(SELF.FirstName contains[c] %@) OR (SELF.LastName contains[c] %@)", searchText, searchText)
                arrRemainder = arrRemainder.filter(predicate)
                tblRemainderList.reloadData()
            }
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
