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
