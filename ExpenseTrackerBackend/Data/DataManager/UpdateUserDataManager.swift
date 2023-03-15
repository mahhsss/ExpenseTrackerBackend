//
//  UpdateUserDataManager.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 14/03/23.
//

import Foundation

public class UpdateUserDataManager: UpdateUserDataContract {
    
    var database: UpdateUserDatabaseContract
    
    public init(database: UpdateUserDatabaseContract) {
        self.database = database
    }
    
    public func updateUser(user: User, column: String, update: Any, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void) {
        self.database.updateUser(user: user, column: column, update: update) { [weak self] (response) in
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
