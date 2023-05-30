//
//  GetBudget.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 29/05/23.
//

import Foundation
import VTComponents

public class GetBudgetRequest: Request {
    
    var userId: Int
    var month: String
    
    public init(userId: Int, month: String) {
        self.userId = userId
        self.month = month
    }
}

public class GetBudgetResponse: ZResponse {
    
    public var budget: Int
    public var spent: Int
    
    public init(budget: Int, spent: Int) {
        self.budget = budget
        self.spent = spent
    }
}

public class GetBudgetError: ZError {
    
    public var error: Error
    public init(error: Error) {
        self.error = error
        super.init(status: .unknownError)
    }
}


public class GetBudget: ZUsecase<GetBudgetRequest, GetBudgetResponse, GetBudgetError> {
    
    var dataManager: GetBudgetDataProtocal
    
    public init(dataManager: GetBudgetDataProtocal) {
        self.dataManager = dataManager
    }
    
    public override func run(request: GetBudgetRequest, success: @escaping (GetBudgetResponse) -> Void, failure: @escaping (GetBudgetError) -> Void) {
        
        self.dataManager.getBudget(userId: request.userId, month: request.month) { [weak self] (budget, transactions) in
            var spent = 0
            for i in transactions {
                if i.transactionType == .spending {
                    spent += i.amount
                }
            }
            self?.success(callback: success, budget: budget, spent: spent)
        } failure: { [weak self] (error) in
            self?.failure(error: error, callback: failure)
        }

    }
    
    private func success(callback: @escaping (GetBudgetResponse) -> Void, budget: Int, spent: Int) {
        invokeSuccess(callback: callback, response: GetBudgetResponse(budget: budget, spent: spent))
    }
    
    private func failure(error: Error, callback: @escaping (GetBudgetError) -> Void) {
        invokeFailure(callback: callback, failure: GetBudgetError(error: error))
    }
}
