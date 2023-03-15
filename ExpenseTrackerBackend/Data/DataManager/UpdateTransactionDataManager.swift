//
//  UpdateTransactionDataManager.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 14/03/23.
//

import Foundation


public class UpdateTransactionDataManager: UpdateTransactionDataContract {
    
    var database: UpdateTranasctionDatabaseContract
    
    public init(database: UpdateTranasctionDatabaseContract) {
        self.database = database
    }
    
    public func updateTransaction(user: User, transaction: Transaction, column: String, update: Any, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void) {
        self.database.updateTransaction(user: user, transaction: transaction, column: column, update: update) { [weak self] (response) in
            self?.sucess(callback: success, response: response)
        } failure: { [weak self] (error) in
            self?.failure(callback: failure, error: error)
        }
    }
    
    private func sucess(callback: (String) -> Void, response: String) {
        callback(response)
    }
    private func failure(callback: @escaping (Error) -> Void, error: Error) {
        callback(error)
    }
}
