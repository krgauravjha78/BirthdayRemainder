//
//  RemaindersFunction.swift
//  BirthDayReminder
//
//  Created by iWizards XI on 15/02/19.
//  Copyright © 2019 iWizards XI. All rights reserved.
//

import Foundation
import RealmSwift

class RealmFunctionsForRemainderTable: NSObject{
    
    static let sharedInstance = RealmFunctionsForRemainderTable()
    
    func  InsertDataIntoRemainderTable(remainderDataArray:[[String:String]])  {
        
        for Object in remainderDataArray{
            let  messageObject = Remainder_Tbl()
            if let id = Object["ID"]{
                messageObject.Id = id
            }
            if let createdDate = Object["CreatedDate"] {
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "yyyyMMddHHmmssSSS"
//                let dateVal = dateFormatter.date(from: createdDate)
//                dateFormatter.dateFormat = "dd-MMM-YYYY HH:mm:ss"
//                let dateString = dateFormatter.string(from: dateVal!)
//                print(dateString)
//                messageObject.Date = dateString
                messageObject.Date = createdDate
            }
            if let firstName = Object["FirstName"]{
                messageObject.FirstName = firstName
            }
            if let lastName = Object["LastName"]{
                messageObject.LastName = lastName
            }
            if let occasion = Object["Occasion"]{
                messageObject.Occasion = occasion
            }
            if let emailId = Object["Email"]{
                messageObject.EmailId = emailId
            }
            if let comment = Object["Comment"]{
                messageObject.Comments = comment
            }
            
            messageObject.persistData(MessageTableData: messageObject)
        }
    }
    func QueryDataFromRemainderTable()-> Results<Remainder_Tbl>{
        do{
            let realm = try! Realm()
            let messageObject = realm.objects(Remainder_Tbl.self)
            return messageObject
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    func QueryDataFromRemainderTableForStatus(status: String)-> Results<Remainder_Tbl>{
        let realm = try! Realm()
        let messageObject = realm.objects(Remainder_Tbl.self).filter("Status == '\(status)'")
        return messageObject
    }
    
    func QueryDataFromRemainderTableForInsightId(InsightId: String)-> Results<Remainder_Tbl>{
        let realm = try! Realm()
        let messageObject = realm.objects(Remainder_Tbl.self).filter("InsightID == '\(InsightId)'")
        return messageObject
    }
}

