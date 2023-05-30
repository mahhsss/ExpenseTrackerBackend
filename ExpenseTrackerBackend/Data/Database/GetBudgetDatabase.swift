//
//  GetBudgetDatabase.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 29/05/23.
//

import Foundation
import VTComponents

public class GetBudgetDatabase: BudgetDatabase {
    
    public override init() { }
}

extension GetBudgetDatabase: GetBudgetDatabaseContract {
    
    public func getBudget(userId: Int, month: String, success: @escaping (Int, [Transaction]) -> Void, failure: @escaping (Error) -> Void) {
        
        let transactionsResult = GetBudgetTransactions()
        let transactions = transactionsResult.getTransactions(userId: userId, month: month)
        let result = database.getBudgetAnalysis(tableName: "Budget", column: budgetDatabaseColumn, columnName: "monthAndYear", columnValue1: month, userId: userId)
        if result.count != 0 {
            let budgetArray = result[0]
            success(budgetArray["budgetAmount"] as! Int, transactions)
        }
        else {
            failure(ZErrorType.dataNotFound)
        }
        
    }
}


public class GetBudgetTransactions: TransactionDatabase {
    
    public override init() { }
    
    func getTransactions(userId: Int, month: String) -> [Transaction]{
        
        let date = month + "-01"
        let startDate = date
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
        return transactions
    }
}
