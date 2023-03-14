//
//  UpdateTransaction.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 27/02/23.
//

import Foundation
import VTComponents

public class UpdateTransactionRequest: ZRequest {
    
    public var user: User
    public var column: String
    public var update: Any
    var transaction: Transaction
    public init(user: User, column: String, update: Any, transaction: Transaction) {
        self.user = user
        self.column = column
        self.update = update
        self.transaction = transaction
        super.init(zuid: "")
    }
}

public class UpdateTransactionResponse: ZResponse {
    
    public var message: String
    public init(message: String) {
        self.message = message
    }
}

public class UpdateTransactionError: ZError {
    
    public var error: Error
    public init(error: Error) {
        self.error = error
        super.init(status: .unknownError)
    }
}


public class UpdateTransaction: ZUsecase<UpdateTransactionRequest, UpdateTransactionResponse, UpdateTransactionError> {
    
    var dataManager: UpdateTransactionDataContract
    public init(dataManager: UpdateTransactionDataContract) {
        self.dataManager = dataManager
    }
    public override func run(request: UpdateTransactionRequest, success: @escaping (UpdateTransactionResponse) -> Void, failure: @escaping (UpdateTransactionError) -> Void) {
        self.dataManager.updateTransaction(user: request.user, transaction: request.transaction, column: request.column, update: request.update) { [weak self] (response) in
            self?.success(callback: success, response: response)
        } failure: { [weak self] (error) in
            self?.failure(callback: failure, error: error)
        }
    }
    
    private func success(callback: @escaping (UpdateTransactionResponse) -> Void, response: String) {
        invokeSuccess(callback: callback, response: UpdateTransactionResponse(message: response))
    }
    private func failure(callback: @escaping (UpdateTransactionError) -> Void, error: Error) {
        invokeFailure(callback: callback, failure: UpdateTransactionError(error: error))
    }
}
