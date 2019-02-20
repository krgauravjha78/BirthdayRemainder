//
//  ContactFunction.swift
//  BirthDayReminder
//
//  Created by iWizards XI on 19/02/19.
//  Copyright © 2019 iWizards XI. All rights reserved.
//

import Foundation
import RealmSwift

class RealmFunctionsForContactTable: NSObject{
    
    static let sharedInstance = RealmFunctionsForContactTable()
    
    func  InsertDataIntoContactTable(contactDataArray:[[String:String]])  {
        
        for Object in contactDataArray{
            let  messageObject = Contact_Tbl()
            
            if let id = Object["Id"]{
                messageObject.Id = id
            }
            if let firstName = Object["FirstName"]{
                messageObject.FirstName = firstName
            }
            if let lastName = Object["LastName"]{
                messageObject.LastName = lastName
            }
            if let emailId = Object["Email"]{
                messageObject.EmailId = emailId
            }
            if let contact = Object["Contact"]{
                messageObject.ContactNumber = contact
            }
            
            messageObject.persistData(MessageTableData: messageObject)
        }
    }
    func QueryDataFromContactTable()-> Results<Contact_Tbl>{
        do{
            let realm = try! Realm()
            let messageObject = realm.objects(Contact_Tbl.self)
            return messageObject
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    func QueryDataFromContactTableForId(id: String)-> Results<Contact_Tbl>{
        let realm = try! Realm()
        let messageObject = realm.objects(Contact_Tbl.self).filter("Id == '\(id)'")
        return messageObject
    }
    
}
