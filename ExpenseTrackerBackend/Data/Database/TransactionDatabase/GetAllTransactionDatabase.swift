//
//  GetAllTransactionDatabase.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 08/03/23.
//

import Foundation
import VTComponents

public class GetAllTransactionDatabase: TransactionDatabase {
    
    public override init() { }
}

extension GetAllTransactionDatabase: GetAddTransactionDatabase {
   
    public func getTransaction(user: User, success: @escaping ([Transaction]) -> Void, failure: @escaping (Error) -> Void) {
        let result = database.getArrayData(tableName: "\"Transaction\"", column: transactionDatabaseColumn, columnName: "userId", columnValue: user.userId)
        var categories: [Transaction] = []
        for row in result {
            
            let category = Transaction(transactionId: row["transactionId"] as! Int, userId: row["userId"] as! Int, amount: row["amount"] as! Int, transactionType: row["transactionType"] as! TransactionType, currencyType: row["currencyType"] as! CurrencyType, date: row["date"] as! String)
            categories.append(category)
        }
        if !categories.isEmpty {
            success(categories)
        }
        else {
            failure(ZErrorType.dataNotFound)
        }
    }

    
    
}

