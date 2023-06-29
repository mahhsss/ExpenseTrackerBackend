//
//  AddTransaction.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 27/02/23.
//

import Foundation
import VTComponents

public class AddNewTransactionRequest: Request {
    
    var userId: Int
    var transaction: Transaction
    public init(userId: Int, transaction: Transaction) {
        self.userId = userId
        self.transaction = transaction
    }
}

public class AddNewTransactionResponse: ZResponse {
    
    public let transactionId : Int
    init(transactionId: Int) {
        self.transactionId = transactionId
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
        dataManager.addTransaction(userId: request.userId, transaction: request.transaction) { [weak self] (response) in
            self?.success(callback: success, response: response)
        } failure: { [weak self] (error) in
            self?.failure(callback: failure, error: error)
        }

    }
    
    private func success(callback: @escaping (AddNewTransactionResponse) -> Void, response: Int) {
        invokeSuccess(callback: callback, response: AddNewTransactionResponse(transactionId: response))
    }
    
    private func failure(callback: @escaping (AddNewTransactionError) -> Void, error: Error) {
        invokeFailure(callback: callback, failure: AddNewTransactionError(error: error))
    }
    
}
