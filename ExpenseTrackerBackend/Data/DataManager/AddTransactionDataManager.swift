//
//  AddTransactionDataManager.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 03/03/23.
//

import Foundation

public class AddNewTransactionDataManager: AddTransactionDataContract {
   
    let database: AddTransactionDatabaseContract
    
    public init(database: AddTransactionDatabaseContract) {
        self.database = database
    }
    
    public func addTransaction(userId: Int, transaction: Transaction, success: @escaping (Int) -> Void, failure: @escaping (Error) -> Void) {
        database.addTransaction(userId: userId, transaction: transaction) { [weak self] (response) in
            self?.success(callback: success, response: response)
        } failure: { [weak self] (error) in
            self?.failure(callback: failure, error: error)
        }

    }
    
    private func success(callback: (Int) -> Void, response: Int) {
        callback(response)
    }
    
    private func failure(callback: @escaping (Error) -> Void, error: Error) {
        callback(error)
    }
    
}
