//
//  AddTransaction.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 27/02/23.
//

import Foundation
import VTComponents

public class AddNewTransactionRequest: Request {
    
    var user: User
    var transaction: Transaction
    public init(user: User, transaction: Transaction) {
        self.user = user
        self.transaction = transaction
    }
}

public class AddNewTransactionResponse: ZResponse {
    
    public let message : String
    init(message: String) {
        self.message = message
    }
}

public class AddNewTransactionError: ZError {
    
    public let error: Error
    public init(error: Error) {
        self.error = error
        super.init(status: .unknownError)
    }
}

public class AddNewTransaction: ZUsecase<AddNewTransactionRequest, AddNewTransactionResponse, AddNewTransactionError> {
    
    var dataManager: AddTransactionDataContract
    
    public init(dataManager: AddTransactionDataContract) {
        self.dataManager = dataManager
    }
    
    public override func run(request: AddNewTransactionRequest, success: @escaping (AddNewTransactionResponse) -> Void, failure: @escaping (AddNewTransactionError) -> Void) {
        dataManager.addTransaction(user: request.user, transaction: request.transaction) { [weak self] (response) in
            self?.success(callback: success, response: response)
        } failure: { [weak self] (error) in
            self?.failure(callback: failure, error: error)
        }

    }
    
    private func success(callback: @escaping (AddNewTransactionResponse) -> Void, response: String) {
        invokeSuccess(callback: callback, response: AddNewTransactionResponse(message: response))
    }
    
    private func failure(callback: @escaping (AddNewTransactionError) -> Void, error: Error) {
        invokeFailure(callback: callback, failure: AddNewTransactionError(error: error))
    }
    
}
