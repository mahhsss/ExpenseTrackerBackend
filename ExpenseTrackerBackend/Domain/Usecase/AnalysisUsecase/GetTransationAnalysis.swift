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
    public var startDate: String
    public var endDate: String
    
    public init(user: User, startDate: String, endDate: String) {
        self.user = user
        self.startDate = startDate
        self.endDate = endDate
        super.init(zuid: "")
    }
}

public class GetTransactionAnalysisResponse: ZResponse {
    
    public var transaction: [Transaction]
    public var analysis: [String: Int]
    public var totalExpense: Int
    public init(transaction: [Transaction], analysis: [String: Int], totalExpense: Int) {
        self.transaction = transaction
        self.analysis = analysis
        self.totalExpense = totalExpense
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
    var categoryWiseAnalysis: [String: Int] = [:]
    public init(dataManager: GetTransactionAnalysisDataContract) {
        self.dataManager = dataManager
    }
    
    public override func run(request: GetTransactionAnalysisRequest, success: @escaping (GetTransactionAnalysisResponse) -> Void, failure: @escaping (GetTransactionAnalysisError) -> Void) {
        
        
        self.dataManager.getTransactionAnalysis(user: request.user, startDate: request.startDate, endDate: request.endDate) { [weak self] (response) in
            self?.success(callback: success, response: response)
        } failure: { [weak self] (error) in
            self?.failure(callback: failure, error: error)
        }

    }
    
    private func success(callback: @escaping (GetTransactionAnalysisResponse) -> Void, response: [Transaction]) {
        var analysis: [String: Int] = [:]
        var totalExpense = 0
        for item in response {
            if item.transactionType == .spending {
                if item.category != nil {
                    if analysis[item.category!] != nil {
                        analysis[item.category!]! += item.amount
                    }
                    else {
                        analysis[item.category!] = item.amount
                    }
                }
                else {
                    if analysis["nil"] != nil {
                        analysis["nil"]! += item.amount
                    }
                    else {
                        analysis["nil"] = item.amount
                    }
                }
                totalExpense += item.amount
            }
        }
        var transactionResponse = GetTransactionAnalysisResponse(transaction: response, analysis: analysis, totalExpense: totalExpense)
        invokeSuccess(callback: callback, response: transactionResponse)
    }
    private func failure(callback: @escaping (GetTransactionAnalysisError) -> Void, error: Error) {
        invokeFailure(callback: callback, failure: GetTransactionAnalysisError(error: error))
    }
}

