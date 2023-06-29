//
//  DeleteTransaction.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 14/03/23.
//

import Foundation
import VTComponents

public class DeleteTransactionRequest: Request {
    
    var transactionId: Int
    public init(transactionId: Int) {
        self.transactionId = transactionId
    }
}

public class DeleteTransactionResponse: ZResponse {
    
    public var message: String
    public init(message: String) {
        self.message = message
    }
}

public class DeleteTransactionError: ZError {
    
    public var error: Error
    public init(error: Error) {
        self.error = error
        super.init(status: .unknownError)
    }
}

public class DeleteTransaction: ZUsecase<DeleteTransactionRequest, DeleteTransactionResponse, DeleteTransactionError> {
    
    var dataManager: DeleteTransactionDataContract
    
    public init(dataManager: DeleteTransactionDataContract) {
        self.dataManager = dataManager
    }
    public override func run(request: DeleteTransactionRequest, success: @escaping (DeleteTransactionResponse) -> Void, failure: @escaping (DeleteTransactionError) -> Void) {
        dataManager.deleteTransaction(transactionId: request.transactionId) { [weak self] (response) in
            self?.success(callback: success, response: response)
        } failure: { [weak self] (error) in
            self?.failure(callback: failure, error: error)
        }
    }
    
    private func success(callback: @escaping (DeleteTransactionResponse) -> Void, response: String) {
        invokeSuccess(callback: callback, response: DeleteTransactionResponse(message: response))
    }
    
    private func failure(callback: @escaping (DeleteTransactionError) -> Void, error: Error) {
        invokeFailure(callback: callback, failure: DeleteTransactionError(error: error))
    }
}
