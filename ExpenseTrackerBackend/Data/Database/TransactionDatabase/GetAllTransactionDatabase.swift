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

extension GetAllTransactionDatabase: GetAllTransactionDatabaseContract {
   
    public func getTransaction(user: User, success: @escaping ([Transaction]) -> Void, failure: @escaping (Error) -> Void) {
        let result = database.getArrayData(tableName: "\"Transaction\"", column: transactionDatabaseColumn, columnName: "userId", columnValue: user.userId)
        var transactions: [Transaction] = []
        print("\n\n\n\n\n\(result[0])\n\n\n\n\n\n")
        for row in result {
            var transactionType: TransactionType = .spending
            var currencyType: CurrencyType = .bankTransaction
            if row["transactionType"] as! String == "Income" {
                transactionType = .income
            }
            if row["currencyType"] as! String == "Cash" {
                currencyType = .cash
            }
            let category = Transaction(transactionId: row["transactionId"] as! Int, userId: row["userId"] as! Int, amount: row["amount"] as! Int, transactionType: transactionType, currencyType: currencyType, date: row["date"] as! String, category: row["category"] as? String, note: row["note"] as? String)
            transactions.append(category)
        }
        if !transactions.isEmpty {
            success(transactions)
        }
        else {
            failure(ZErrorType.dataNotFound)
        }
    }
    
}

