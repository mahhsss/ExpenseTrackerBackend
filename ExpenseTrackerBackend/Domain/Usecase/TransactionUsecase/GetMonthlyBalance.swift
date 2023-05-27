//
//  GetMonthlyBalance.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 27/05/23.
//

import Foundation
import VTComponents

public class GetMonthlyBalanceRequest: Request {
    
    var userId: Int
    var month: String
    
    public init(userId: Int, month: String) {
        self.userId = userId
        self.month = month
    }
}

public class GetMonthlyBalanceResponse: ZResponse {
    
    public var balance: Int
    
    public init(balance: Int) {
        self.balance = balance
    }
}

public class GetMonthlyBalanceError: ZError {
    
    public var error: Error
    
    public init(error: Error) {
        self.error = error
        super.init(status: .unknownError)
    }
}

public class GetMonthlyBalance: ZUsecase<GetMonthlyBalanceRequest, GetMonthlyBalanceResponse, GetMonthlyBalanceError> {
    
    var dataManager: GetMonthlyBalanceDataProtocol
    
    public init(dataManager: GetMonthlyBalanceDataProtocol) {
    
        self.dataManager = dataManager
    }
    
    public override func run(request: GetMonthlyBalanceRequest, success: @escaping (GetMonthlyBalanceResponse) -> Void, failure: @escaping (GetMonthlyBalanceError) -> Void) {
        dataManager.getMonthlyBalance(userId: request.userId, month: request.month) { [weak self] (response) in
            var balance = 0
            var income = 0
            var spent = 0
            for i in response {
                if i.transactionType == .income {
                    income += i.amount
                }
                if i.transactionType == .spending {
                    spent += i.amount
                }
                balance = income - spent
                if balance > 0 {
                    self?.success(callback: success, response: balance)
                }
                else {
                    self?.success(callback: success, response: 0)
                }
            }
        } failure: { [weak self] (error) in
            self?.failure(callback: failure, error: error)
        }

    }
    
    private func success(callback: @escaping (GetMonthlyBalanceResponse) -> Void, response: Int) {
        
        invokeSuccess(callback: callback, response: GetMonthlyBalanceResponse(balance: response))
    }
    
    private func failure(callback: @escaping (GetMonthlyBalanceError) -> Void, error: Error) {
        
        invokeFailure(callback: callback, failure: GetMonthlyBalanceError(error: error))
    }
}
