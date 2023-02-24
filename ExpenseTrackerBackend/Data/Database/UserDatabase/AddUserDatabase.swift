//
//  AddUserDatabase.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 24/02/23.
//

import Foundation

public class AddUserDataDatabaseService: UserDatabase {
   
    public override init() { }
    
}

extension AddUserDataDatabaseService: AddUserDatabaseContract {
   
    public func addUser(user: User, success: @escaping () -> Void, failure: @escaping () -> Void) {
        var value: [String: Any] = [:]
        value["userId"] = user.userId
        value["name"] = user.name
        value["emailId"] = user.emailId
        value["password"] = user.password
        let result = database.addValue(tableName: "User", columns: userDatabaseColumn, values: value)
        
        if result {
            success()
        }
        else {
            failure()
        }
    }
    
}
