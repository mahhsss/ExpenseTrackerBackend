//
//  GetAllTransaction.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 27/02/23.
//

import Foundation
import VTComponents

public class GetAllTransactionRequest: Request {
    
    public var userId: Int
    public init(userId: Int) {
        self.userId = userId
    }
}

public class GetAllTransactionResponse: Response {
    
    public var transactions: [Transaction]
    public init(transactions: [Transaction]) {
        self.transactions = transactions
    }
    
}

public class GetAllTransactionError: ZError {
    
    public var error: Error
    public init(error: Error) {
        self.error = error
        super.init(status: .unknownError)
    }
}

public class GetAllTransaction: ZUsecase<GetAllTransactionRequest, GetAllTransactionResponse, GetAllTransactionError> {
    
    var dataManager: GetAllTransactionDataProtocol
    
    public init(dataManager: GetAllTransactionDataProtocol) {
        self.dataManager = dataManager
    }
    
    public override func run(request: GetAllTransactionRequest, success: @escaping (GetAllTransactionResponse) -> Void, failure: @escaping (GetAllTransactionError) -> Void) {
        self.dataManager.getAllTransaction(userId: request.userId) { [weak self] (response) in
            let transactions = Array(response.reversed())
            self?.success(callback: success, response: transactions)
        } failure: { [weak self] (error) in
            self?.failure(callback: failure, error: error)
        }

    }
    
    private func success(callback: @escaping (GetAllTransactionResponse) -> Void, response: [Transaction]) {
        invokeSuccess(callback: callback, response: GetAllTransactionResponse(transactions: response))
    }
    private func failure(callback: @escaping (GetAllTransactionError) -> Void, error: Error) {
        invokeFailure(callback: callback, failure: GetAllTransactionError(error: error))
    }
}
