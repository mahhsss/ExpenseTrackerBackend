//
//  DeleteTransactionDataManager.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 14/03/23.
//

import Foundation


public class DeleteTransactionDataManager: DeleteTransactionDataContract {
    
    var database: DeleteTransactionDatabaseContract
    
    public init(database: DeleteTransactionDatabaseContract) {
        self.database = database
    }
    
    public func deleteTransaction(user: User, transaction: Transaction, columnName: String, columnValue: Any, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void) {
        self.database.deleteTransaction(user: user, transaction: transaction, columnName: columnName, columnValue: columnValue) { [weak self] (response) in
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
