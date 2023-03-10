//
//  GetTransactionAnalysisDatabase.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 10/03/23.
//

import Foundation
import VTComponents


public class GetTransactionAnalysisDatabase: TransactionDatabase {
    
    public override init() { }
}

extension GetTransactionAnalysisDatabase: GetTransactionAnalysisDatabaseContract {
    
    public func getTransactionAnalysis(user: User, startDate: String, endDate: String, success: @escaping ([Transaction]) -> Void, failure: @escaping (Error) -> Void) {
        let result = database.getTransactionAnalysis(tableName: "\"Transaction\"", column: transactionDatabaseColumn, columnName: "date", columnValue1: startDate, columnValue2: endDate)
        var transactions: [Transaction] = []
        for row in result {
            var transactionType: TransactionType = .spending
            var currencyType: CurrencyType = .bankTransaction
            if row["transactionType"] as! String == "Income" {
                transactionType = .income
            }
            if row["currencyType"] as! String == "Cash" {
                currencyType = .cash
            }
            let transaction = Transaction(transactionId: row["transactionId"] as! Int, userId: row["userId"] as! Int, amount: row["amount"] as! Int, transactionType: transactionType, currencyType: currencyType, date: row["date"] as! String)
            transactions.append(transaction)
        }
        if !transactions.isEmpty {
            success(transactions)
        }
        else {
            failure(ZErrorType.dataNotFound)
        }
    }
}
