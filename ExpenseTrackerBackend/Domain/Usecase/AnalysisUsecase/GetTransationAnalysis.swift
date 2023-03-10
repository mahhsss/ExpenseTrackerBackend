//
//  GetTransation.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 27/02/23.
//

import Foundation
import VTComponents

public class GetTransactionAnalysisRequest: ZRequest {
    
    public var user: User
    public var month: String
    
    public init(user: User, month: String) {
        self.user = user
        self.month = month
        super.init(zuid: "")
    }
}

public class GetTransactionAnalysisResponse: ZResponse {
    
    public var transaction: [Transaction]
    public var analysis: [String: Any]?
    
    public init(transaction: [Transaction]) {
        self.transaction = transaction
    }
}

public class GetTransactionAnalysisError: ZError {
    
    public var error: Error
    public init(error: Error) {
        self.error = error
        super.init(status: .unknownError)
    }
}

public class GetTransactionAnalysis: ZUsecase<GetTransactionAnalysisRequest, GetTransactionAnalysisResponse, GetTransactionAnalysisError> {
    
    var dataManager: GetTransactionAnalysisDataContract
    
    public init(dataManager: GetTransactionAnalysisDataContract) {
        self.dataManager = dataManager
    }
    
    public override func run(request: GetTransactionAnalysisRequest, success: @escaping (GetTransactionAnalysisResponse) -> Void, failure: @escaping (GetTransactionAnalysisError) -> Void) {
        
        let endMonth: String = "2023-08-01"
        self.dataManager.getTransactionAnalysis(user: request.user, startDate: request.month, endDate: endMonth) { [weak self] (response) in
            self?.success(callback: success, response: response)
        } failure: { [weak self] (error) in
            self?.failure(callback: failure, error: error)
        }

    }
    
    private func success(callback: @escaping (GetTransactionAnalysisResponse) -> Void, response: [Transaction]) {
        invokeSuccess(callback: callback, response: GetTransactionAnalysisResponse(transaction: response))
    }
    private func failure(callback: @escaping (GetTransactionAnalysisError) -> Void, error: Error) {
        invokeFailure(callback: callback, failure: GetTransactionAnalysisError(error: error))
    }
}

