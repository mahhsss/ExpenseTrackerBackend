//
//  GetBudgetDataManager.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 29/05/23.
//

import Foundation

public class GetBudgetDataManager: GetBudgetDataProtocal {
    
    var database: GetBudgetDatabaseContract
    
    public init(database: GetBudgetDatabaseContract) {
        self.database = database
    }
    
    public func getBudget(userId: Int, month: String, success: @escaping (Int, [Transaction]) -> Void, failure: @escaping (Error) -> Void) {
        
        self.database.getBudget(userId: userId, month: month) { [weak self] (budget, transactions) in
            self?.success(callback: success, budget: budget, transactions: transactions)
        } failure: { [weak self] (error) in
            self?.failure(callback: failure, error: error)
        }

    }
    
    private func success(callback: (Int, [Transaction]) -> Void, budget: Int, transactions: [Transaction]) {
        callback(budget, transactions)
    }
    
    private func failure(callback: (Error) -> Void, error: Error) {
        callback(error)
    }
        
}
