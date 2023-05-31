//
//  GetRecentTransactionDataManager.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 31/05/23.
//

import Foundation

public class GetRecentTransactionDataManager: GetRecentTransactionDataProtocol {
    
    var database: GetRecentTransactionDatabaseContract
    
    public init(database: GetRecentTransactionDatabaseContract) {
        self.database = database
    }
    
    public func getRecentTransaction(userId: Int, month: String, success: @escaping ([Transaction]) -> Void, failure: @escaping (Error) -> Void) {
        self.database.getRecentTransaction(userId: userId, month: month) { [weak self] (response) in
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
