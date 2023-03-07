//
//  UserSignInDataManager.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 24/02/23.
//

import Foundation

public class UserLoginDataManagerService: UserLoginDataContract {
    
    var database: GetUserDatabaseContract
    
    public init(database: GetUserDatabaseContract) {
        self.database = database
    }
    public func userLogin(emailId: String, password: String, success: @escaping (User) -> Void, failure: @escaping (Error) -> Void) {
        database.getUser(emailId: emailId, password: password) { [weak self] (response) in
            self?.success(callback: success, response: response)
        } failure: { [weak self] error in
            self?.failure(callback: failure, error: error)
        }

    }
    
    func success(callback: (User) -> Void, response: User) {
        callback(response)
    }
    
    func failure(callback: (Error) -> Void, error: Error) {
        callback(error)
    }
}
