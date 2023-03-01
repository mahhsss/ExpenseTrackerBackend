//
//  UserSignInDataManager.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 24/02/23.
//

import Foundation

public class UserLoginDataManagerServise: UserLoginDataContract {
    
    var database: UserLoginDataContract
    
    public init(database: UserLoginDataContract) {
        self.database = database
    }
    public func userLogin(emailId: String, password: String, response: @escaping (User) -> Void, failure: @escaping (Error) -> Void) {
        database.userLogin(emailId: emailId, password: password, response: <#T##(User) -> Void#>, failure: <#T##(Error) -> Void#>)
    }
    
    func success(callback: (User) -> Void, response: User) {
        callback(response)
    }
    
    func failure(callback: @escaping (Error) -> Void, error: Error) {
        callback(error)
    }
}
