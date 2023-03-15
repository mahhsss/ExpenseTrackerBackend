//
//  AddMonthlyAnalysisTransaction.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 15/03/23.
//

import Foundation
import VTComponents

public class AddMonthlyAnalysisTransactionRequest: ZRequest {
    
    var user: User
    var transaction: Transaction
    public init(user: User, transaction: Transaction) {
        self.user = user
        self.transaction = transaction
        super.init(zuid: " ")
    }
}

public class AddMonthlyAnalysisTransactionResponse: ZResponse {
    
    public let message : String
    init(message: String) {
        self.message = message
    }
}

public class AddMonthlyAnalysisTransactionError: ZError {
    
    public let error: Error
    public init(error: Error) {
        self.error = error
        super.init(status: .unknownError)
    }
}

public class AddMonthlyAnalysisTransaction: ZUsecase<AddMonthlyAnalysisTransactionRequest, AddMonthlyAnalysisTransactionResponse, AddMonthlyAnalysisTransactionError> {
    
    var dataManager: AddMonthlyAnalysisTransactionDataContract
    
    public init(dataManager: AddMonthlyAnalysisTransactionDataContract) {
        self.dataManager = dataManager
    }
    
    public override func run(request: AddMonthlyAnalysisTransactionRequest, success: @escaping (AddMonthlyAnalysisTransactionResponse) -> Void, failure: @escaping (AddMonthlyAnalysisTransactionError) -> Void) {
        self.dataManager.addMonthlyAnalysisTransaction(user: request.user, transaction: request.transaction) { [weak self] (response) in
            self?.success(callback: success, response: response)
        } failure: { [weak self] (error) in
            self?.failure(callback: failure, error: error)
        }

    }
    
    private func success(callback: @escaping (AddMonthlyAnalysisTransactionResponse) -> Void, response: String) {
        invokeSuccess(callback: callback, response: AddMonthlyAnalysisTransactionResponse(message: response))
    }
    
    private func failure(callback: @escaping (AddMonthlyAnalysisTransactionError) -> Void, error: Error) {
        invokeFailure(callback: callback, failure: AddMonthlyAnalysisTransactionError(error: error))
    }
}
