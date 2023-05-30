//
//  BudgetContract.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 15/03/23.
//

import Foundation

public protocol AddBudgetDataContract {
    
    func addBudget(userId: Int, budget: Budget, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void)
}

public protocol GetBudgetDataProtocal {
    
    func getBudget(userId: Int, month: String, success: @escaping (Int, [Transaction]) -> Void, failure: @escaping (Error) -> Void)
}
