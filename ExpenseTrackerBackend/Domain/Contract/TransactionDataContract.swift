//
//  TransactionDataContract.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 03/03/23.
//

import Foundation

public protocol GetRecentTransactionDataProtocol {
    
    func getRecentTransaction(userId: Int, month: String, success: @escaping ([Transaction]) -> Void, failure: @escaping (Error) -> Void)
}

public protocol GetAllTransactionDataProtocol {
    
    func getAllTransaction(userId: Int, success: @escaping ([Transaction]) -> Void, failure: @escaping (Error) -> Void)
}

public protocol AddTransactionDataContract {
    
    func addTransaction(userId: Int, transaction: Transaction, success: @escaping (Int) -> Void, failure: @escaping (Error) -> Void)
}

public protocol UpdateTransactionDataContract {
    
    func updateTransaction(userId: Int, transaction: Transaction, column: String, update: Any, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void)
}

public protocol DeleteTransactionDataContract {
    
    func deleteTransaction(transactionId: Int, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void)
}

public protocol AddMonthlyAnalysisTransactionDataContract {
    
    func addMonthlyAnalysisTransaction(userId: Int, transaction: Transaction, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void)
}
