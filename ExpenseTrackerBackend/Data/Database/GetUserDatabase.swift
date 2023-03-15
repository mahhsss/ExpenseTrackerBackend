//
//  GetUserDatabase.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 01/03/23.
//

import Foundation
import VTComponents


public class GetUserDatabase: UserDatabase {
    
    public override init() { }
}

extension GetUserDatabase: GetUserDatabaseContract {
    
    public func getUser(emailId: String, password: String, response: @escaping (User) -> Void, failure: @escaping (Error) -> Void) {
        
        let result = database.getData(tableName: "User", column: userDatabaseColumn, columnName: "emailId", columnValue: emailId)
        if result.count != 0 {
            if password == result["password"] as! String {
                let user = User(userId: result["userId"] as! Int, name: result["name"] as! String, emailId: result["emailId"] as! String, password: result["password"] as! String)
                response(user)
            }
            else {
                failure(ZErrorType.passwordIncorrect)
            }
            
        }
        else {
            failure(ZErrorType.authenticationFailure)
        }
    }
}
