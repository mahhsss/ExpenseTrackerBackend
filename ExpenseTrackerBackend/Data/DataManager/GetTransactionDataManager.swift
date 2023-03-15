//
//  GetTransactionDataManager.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 08/03/23.
//

import Foundation

public class GetAllTransactionDataManager: GetAllTransactionDataProtocol {
    
    
   
    var database: GetAllTransactionDatabaseContract
    public init(database: GetAllTransactionDatabaseContract) {
        self.database = database
    }
    
    public func getAllTransaction(user: User, success: @escaping ([Transaction]) -> Void, failure: @escaping (Error) -> Void) {
        self.database.getTransaction(user: user) { [weak self] (response) in
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
