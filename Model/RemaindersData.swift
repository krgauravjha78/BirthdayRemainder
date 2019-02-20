//
//  RemaindersData.swift
//  BirthDayReminder
//
//  Created by iWizards XI on 15/02/19.
//  Copyright © 2019 iWizards XI. All rights reserved.
//

import Foundation
import RealmSwift

class Remainder_Tbl : Object{
    
    @objc dynamic var Id = ""
    @objc dynamic var FirstName = ""
    @objc dynamic var LastName = ""
    @objc dynamic var Date = ""
    @objc dynamic var EmailId = ""
    @objc dynamic var Occasion = ""
    @objc dynamic var Comments = ""
    
    
    override static func primaryKey() -> String?{
        return "Id"
    }
    
    func  persistData(MessageTableData: Remainder_Tbl)  {
        let realm = try! Realm()
        try! realm.write({
            realm.add(MessageTableData, update:true)
        })
    }
    
    func deleteDataFromTable(deleteData: Remainder_Tbl){
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func DeleteDataFromMessageTableForId(deleteData: Remainder_Tbl){
        let realm = try! Realm()
        try! realm.write {
            realm.delete(deleteData)
        }
    }
    
}

