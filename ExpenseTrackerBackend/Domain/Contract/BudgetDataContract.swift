//
//  BudgetContract.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 15/03/23.
//

import Foundation

public protocol AddBudgetDataContract {
    
    func addBudget(user: User, budget: Budget, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void)
}
