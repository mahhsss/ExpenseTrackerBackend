//
//  UserSignUpDataManager.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 24/02/23.
//

import Foundation

public class AddUserDatamanager: AddUserDataContract {
    
    var database: AddUserDatabaseContract
    
    public init(database: AddUserDatabaseContract) {
        self.database = database
    }
    
    public func addUser(user: User, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void) {
        
        database.addUser(user: user) { [weak self] (response) in
            self?.success(callback: success, response: response)
        } failure: { [weak self] (error) in
            self?.failure(callback: failure, error: error)
        }

    }
    
    
    private func success(callback: (String) -> Void, response: String) {
        callback(response)
    }
    
    private func failure(callback: @escaping (Error) -> Void, error: Error) {
        callback(error)
    }
    
}
