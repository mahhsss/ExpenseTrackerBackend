//
//  GetMonthlyIncomeDatabase.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 26/05/23.
//

import Foundation
import VTComponents

public class GetMonthlyIncomeDatabase: TransactionDatabase {
    
    public override init() { }
}

extension GetMonthlyIncomeDatabase: GetMonthlyIncomeDatabaseContract {
    
    public func getmonthlyIncome(userId: Int, month: String, success: @escaping ([Transaction]) -> Void, failure: @escaping (Error) -> Void) {
        
        let startDate = month
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let inputDate = dateFormatter.date(from: startDate)!
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = 1
        let resultDate = calendar.date(byAdding: dateComponents, to: inputDate)!
        let nextMonth = dateFormatter.string(from: resultDate)
        
        
        let result = database.getTransactionAnalysis(tableName: "\"Transaction\"", column: transactionDatabaseColumn, columnName: "date", columnValue1: startDate, columnValue2: nextMonth, userId: userId)
        
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
            let transaction = Transaction(transactionId: row["transactionId"] as! Int, userId: row["userId"] as! Int, amount: row["amount"] as! Int, transactionType: transactionType, currencyType: currencyType, date: row["date"] as! String, category: row["category"] as? String, note: row["note"] as? String)
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
