//
//  AddBudget.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 15/03/23.
//

import Foundation
import VTComponents


public class AddBudgetRequest: ZRequest {
    
    var user: User
    var budget: Budget
    public init(user: User, budget: Budget) {
        self.user = user
        self.budget = budget
        super.init(zuid: "")
    }
}

public class AddBudgetResponse: ZResponse {
    
    public var message: String
    public init(message: String) {
        self.message = message
    }
}

public class AddBudgetError: ZError {
    
    public var error: Error
    public init(error: Error) {
        self.error = error
        super.init(status: .unknownError)
    }
}

public class AddBudget: ZUsecase<AddBudgetRequest, AddBudgetResponse, AddBudgetError> {
    
    var dataManager: AddBudgetDataContract
    
    public init(dataManager: AddBudgetDataContract) {
        self.dataManager = dataManager
    }
    
    public override func run(request: AddBudgetRequest, success: @escaping (AddBudgetResponse) -> Void, failure: @escaping (AddBudgetError) -> Void) {
        self.dataManager.addBudget(user: request.user, budget: request.budget) { [weak self] (response) in
            self?.success(callback: success, response: response)
        } failure: { [weak self] (error) in
            self?.failure(error: error, callback: failure)
        }

    }
    
    private func success(callback: @escaping (AddBudgetResponse) -> Void, response: String) {
        invokeSuccess(callback: callback, response: AddBudgetResponse(message: response))
    }
    
    private func failure(error: Error, callback: @escaping (AddBudgetError) -> Void) {
        invokeFailure(callback: callback, failure: AddBudgetError(error: error))
    }
}
