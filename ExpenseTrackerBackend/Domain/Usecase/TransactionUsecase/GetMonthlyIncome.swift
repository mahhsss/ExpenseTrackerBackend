//
//  GetMonthlyIncome.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 26/05/23.
//

import Foundation
import VTComponents

public class GetMonthlyIncomeRequest: Request {
    
    var userId: Int
    var month: String
    
    public init(userId: Int, month: String) {
        self.userId = userId
        self.month = month
    }
}

public class GetMonthlyIncomeResponse: ZResponse {
    
    public var income: Int
    
    public init(income: Int) {
        self.income = income
    }
}

public class GetMonthlyIncomeError: ZError {
    
    public var error: Error
    
    public init(error: Error) {
        self.error = error
        super.init(status: .unknownError)
    }
}

public class GetMonthlyIncome: ZUsecase<GetMonthlyIncomeRequest, GetMonthlyIncomeResponse, GetMonthlyIncomeError> {
    
    var dataManager: GetMonthlyIncomeDataProtocol
    
    public init(dataManager: GetMonthlyIncomeDataProtocol) {
    
        self.dataManager = dataManager
    }
    
    public override func run(request: GetMonthlyIncomeRequest, success: @escaping (GetMonthlyIncomeResponse) -> Void, failure: @escaping (GetMonthlyIncomeError) -> Void) {
        self.dataManager.getMonthlyIncome(userId: request.userId, month: request.month) { [weak self] (response) in
            var income = 0
            for i in response {
                if i.transactionType == .income {
                    income += i.amount
                }
            }
            self?.success(callback: success, response: income)
        } failure: { [weak self] (error) in
            self?.failure(callback: failure, error: error)
        }
    }
    
    private func success(callback: @escaping (GetMonthlyIncomeResponse) -> Void, response: Int) {
        
        invokeSuccess(callback: callback, response: GetMonthlyIncomeResponse(income: response))
    }
    
    private func failure(callback: @escaping (GetMonthlyIncomeError) -> Void, error: Error) {
        
        invokeFailure(callback: callback, failure: GetMonthlyIncomeError(error: error))
    }
}
