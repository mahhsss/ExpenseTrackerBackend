//
//  AddBudgetDataManager.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 15/03/23.
//

import Foundation

public class AddBudgetDataManager: AddBudgetDataContract {
    
    var database: AddBudgetDatabaseContract
    
    public init(database: AddBudgetDatabaseContract) {
        self.database = database
    }
    
    public func addBudget(user: User, budget: Budget, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void) {
        self.database.addBudget(user: user, budget: budget) { [weak self] (response) in
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
