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
    
    public func addUser(user: User, success: @escaping () -> Void, failure: @escaping (AddNewUserError) -> Void) {
        database.addUser(user: user) { [weak self] () in
            self?.success(callback: success)
        } failure: {
            self.failure(callback: failure)
        }

    }
    
    private func success(callback: () -> Void) {
        callback()
    }
    
    private func failure(callback: ((AddNewUserError) -> Void)) {
        let error = AddNewUserError(type: .invalidRequestError)
        callback(error)
    }
    
}
