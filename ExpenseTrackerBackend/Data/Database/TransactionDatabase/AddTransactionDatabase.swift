//
//  AddTransactionDatabase.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 02/03/23.
//

import Foundation
import VTComponents

public class AddTransactionDataDatabaseService: TransactionDatabase {
    
    public override init() { }
}

extension AddTransactionDataDatabaseService:  AddTransactionDatabaseContract{
    
    public func addTransaction(user: User, transaction: Transaction, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void) {
        
        var value: [String: Any] = [:]
        value["transactionId"] = transaction.transactionId
        value["userId"] = user.userId
        value["amount"] = transaction.amount
        value["transactionType"] = transaction.transactionType.rawValue
        value["currencyType"] = transaction.currencyType.rawValue
        value["date"] = transaction.date
        if transaction.category != nil {
            value["category"] = transaction.category
        }
        else {
            value["category"] = "nil"
        }
        if transaction.note != nil {
            value["note"] = transaction.note
        }
        else {
            value["note"] = "nil"
        }
        let result = database.addValue(tableName: "\"Transaction\"", columns: transactionDatabaseColumn, values: value)
        
        if result {
            success("values Added Successfully")
        }
        else {
            failure(ZErrorType.unknownError)
        }
    }
    
}
