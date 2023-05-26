//
//  GetMonthlySpent.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 25/05/23.
//

import Foundation
import VTComponents

public class GetMonthlySpentRequest: Request {
    
    var userId: Int
    var month: String
    
    public init(userId: Int, month: String) {
        self.userId = userId
        self.month = month
    }
}

public class GetMonthlySpentResponse: ZResponse {
    
    public var spent: Int
    
    public init(spent: Int) {
        self.spent = spent
    }
}

public class GetMonthlySpentError: ZError {
    
    public var error: Error
    
    public init(error: Error) {
        self.error = error
        super.init(status: .unknownError)
    }
}

public class GetMonthlySpent: ZUsecase<GetMonthlySpentRequest, GetMonthlySpentResponse, GetMonthlySpentError> {
    
    var dataManager: GetMonthlySpentDataProtocol
    
    public init(dataManager: GetMonthlySpentDataProtocol) {
        
        self.dataManager = dataManager
    }
    
    public override func run(request: GetMonthlySpentRequest, success: @escaping (GetMonthlySpentResponse) -> Void, failure: @escaping (GetMonthlySpentError) -> Void) {
        self.dataManager.getMonthlySpent(userId: request.userId, month: request.month) { [weak self] (response) in
            var spent = 0
            for i in response {
                if i.transactionType == .spending {
                    spent += i.amount
                }
            }
            self?.success(callback: success, response: spent)
        } failure: { [weak self] (error) in
            self?.failure(callback: failure, error: error)
        }

    }
    
    private func success(callback: @escaping (GetMonthlySpentResponse) -> Void, response: Int) {
        
        invokeSuccess(callback: callback, response: GetMonthlySpentResponse(spent: response))
    }
    
    private func failure(callback: @escaping (GetMonthlySpentError) -> Void, error: Error) {
        
        invokeFailure(callback: callback, failure: GetMonthlySpentError(error: error))
    }
}
