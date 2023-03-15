//
//  TransactionDataContract.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 03/03/23.
//

import Foundation

public protocol GetAllTransactionDataProtocol {
    
    func getAllTransaction(user: User, success: @escaping ([Transaction]) -> Void, failure: @escaping (Error) -> Void)
}

public protocol AddTransactionDataContract {
    
    func addTransaction(user: User, transaction: Transaction, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void)
}

public protocol UpdateTransactionDataContract {
    
    func updateTransaction(user: User, transaction: Transaction, column: String, update: Any, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void)
}

public protocol DeleteTransactionDataContract {
    
    func deleteTransaction(user: User, transaction: Transaction, columnName: String, columnValue: Any, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void)
}

public protocol AddMonthlyAnalysisTransactionDataContract {
    
    func addMonthlyAnalysisTransaction(user: User, transaction: Transaction, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void)
}
