//
//  AddMonthlyAnalysisTransactionDataManager.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 15/03/23.
//

import Foundation


public class AddMonthlyAnalysisTransactionDataManager: AddMonthlyAnalysisTransactionDataContract {
    
    var database: AddMonthlyAnalysisTransactionDatabaseContract
    
    public init(database: AddMonthlyAnalysisTransactionDatabaseContract) {
        self.database = database
    }
    
    public func addMonthlyAnalysisTransaction(userId: Int, transaction: Transaction, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void) {
        self.database.addMonthlyAnalysisTransaction(userId: userId, transasction: transaction) { [weak self] (response) in
            self?.success(callback: success, response: response)
        } failure: { [weak self] (error) in
            self?.failure(callback: failure, error: error)
        }

    }
    
    private func success(callback: (String) -> Void, response: String) {
        callback(response)
    }
    
    private func failure(callback: @escaping (Error) -> Void, error: Error) {
        callback(error)
    }
}
