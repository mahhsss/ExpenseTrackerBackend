//
//  AddCategoryDataManager.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 07/03/23.
//

import Foundation

public class AddCategoryDatamanager: AddCategoryDataContract {
    
    var database: AddCategoryDatabaseContract
    public init(database: AddCategoryDatabaseContract) {
        self.database = database
    }

    public func addCategory(user: User, category: ExpendatureCategory, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void) {
        database.addCategory(user: user, category: category) { [weak self] (response) in
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
