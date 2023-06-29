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
    
    public func addTransaction(userId: Int, transaction: Transaction, success: @escaping (Int) -> Void, failure: @escaping (Error) -> Void) {
        
        var value: [String: Any] = [:]
        value["transactionId"] = transaction.transactionId
        value["userId"] = userId
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
            success(database.executeQuery(query: "SELECT last_insert_rowid();"))
        }
        else {
            failure(ZErrorType.unknownError)
        }
    }
    
}
