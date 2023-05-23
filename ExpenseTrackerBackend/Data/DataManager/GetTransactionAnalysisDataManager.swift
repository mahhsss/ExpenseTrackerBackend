//
//  GetTransactionAnalysisDataManager.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 10/03/23.
//

import Foundation

public class GetTransactionAnalysisDataManager: GetTransactionAnalysisDataContract {
    
    var database: GetTransactionAnalysisDatabaseContract
    
    public init(database: GetTransactionAnalysisDatabaseContract) {
        self.database = database
    }
    
    public func getTransactionAnalysis(userId: Int, startDate: String, endDate: String, success: @escaping ([Transaction]) -> Void, failure: @escaping (Error) -> Void) {
        self.database.getTransactionAnalysis(userId: userId, startDate: startDate, endDate: endDate) { [weak self] (response) in
            self?.success(callback: success, response: response)
        } failure: { [weak self] (error) in
            self?.failure(callback: failure, error: error)
        }

    }
    
    private func success(callback: ([Transaction]) -> Void, response: [Transaction]) {
        callback(response)
    }
    
    private func failure(callback: (Error) -> Void, error: Error) {
        callback(error)
    }

}
