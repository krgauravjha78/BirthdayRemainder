//
//  ContactData.swift
//  BirthDayReminder
//
//  Created by iWizards XI on 19/02/19.
//  Copyright © 2019 iWizards XI. All rights reserved.
//

import Foundation
import RealmSwift

class Contact_Tbl : Object{
    
    @objc dynamic var FirstName = ""
    @objc dynamic var LastName = ""
    @objc dynamic var EmailId = ""
    @objc dynamic var ContactNumber = ""
    @objc dynamic var Id = ""
    
    
    override static func primaryKey() -> String?{
        return "ContactNumber"
    }
    
    func  persistData(MessageTableData: Contact_Tbl)  {
        let realm = try! Realm()
        try! realm.write({
            realm.add(MessageTableData, update:true)
        })
    }
    
    func deleteDataFromTable(deleteData: Contact_Tbl){
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func DeleteDataFromMessageTableForId(deleteData: Contact_Tbl){
        let realm = try! Realm()
        try! realm.write {
            realm.delete(deleteData)
        }
    }
    
}
