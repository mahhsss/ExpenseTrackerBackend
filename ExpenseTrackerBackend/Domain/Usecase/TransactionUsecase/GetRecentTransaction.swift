//
//  GetRecentTransaction.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 31/05/23.
//

import Foundation
import VTComponents

public class GetRecentTransactionRequest: Request {
    
    var userId: Int
    var month: String
    
    public init(userId: Int, month: String) {
        self.userId = userId
        self.month = month
    }
}

public class GetRecentTransactionResponse: ZResponse {
    
    public var transactions: [Transaction]
    
    public init(transactions: [Transaction]) {
        self.transactions = transactions
    }
}

public class GetRecentTransactionError: ZError {
    
    public var error: Error
    
    public init(error: Error) {
        self.error = error
        super.init(status: .unknownError)
    }
}

public class GetRecentTransaction: ZUsecase<GetRecentTransactionRequest, GetRecentTransactionResponse, GetRecentTransactionError> {
    
    var dataManager: GetRecentTransactionDataProtocol
    
    public init(dataManager: GetRecentTransactionDataProtocol) {
        self.dataManager = dataManager
    }
    
    public override func run(request: GetRecentTransactionRequest, success: @escaping (GetRecentTransactionResponse) -> Void, failure: @escaping (GetRecentTransactionError) -> Void) {
        self.dataManager.getRecentTransaction(userId: request.userId, month: request.month) { [weak self] (response) in
            self?.success(callback: success, response: response)
        } failure: { [weak self] (error) in
            self?.failure(callback: failure, error: error)
        }

    }
    
    private func success(callback: @escaping (GetRecentTransactionResponse) -> Void, response: [Transaction]) {
        invokeSuccess(callback: callback, response: GetRecentTransactionResponse(transactions: response))
    }
    private func failure(callback: @escaping (GetRecentTransactionError) -> Void, error: Error) {
        invokeFailure(callback: callback, failure: GetRecentTransactionError(error: error))
    }
}
