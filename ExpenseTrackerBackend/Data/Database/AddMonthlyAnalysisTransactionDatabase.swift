//
//  File.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 15/03/23.
//

import Foundation
import VTComponents

public class AddMonthlyAnalysisTransactionDatabase: BudgetDatabase {
    
    public override init() { }
}

extension AddMonthlyAnalysisTransactionDatabase: AddMonthlyAnalysisTransactionDatabaseContract {
    
    public func addMonthlyAnalysisTransaction(userId: Int, transasction: Transaction, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void) {
        var values: [String: Any] = [:]
        values["monthlyAnalysisId"] = 0
        values["userId"] = userId
        values["budgetAmount"] = 0
        values["monthAndYear"] = transasction.date.dropLast(3)
        values["spentAmount"] = transasction.amount
        var check: Bool = false
        var spentAmount = 0
        var budgetAmount = 0
        var monthlyAnalysisId = 0
        let result = database.getArrayData(tableName: "Budget", column: budgetDatabaseColumn, columnName: "userId", columnValue: userId)
        for row in result {
            if row["monthAndYear"] as! String == transasction.date.dropLast(3) {
                check = true
                spentAmount = row["spentAmount"] as! Int
                budgetAmount = row["budgetAmount"] as! Int
                monthlyAnalysisId = row["monthlyAnalysisId"] as! Int
                values["budgetAmount"] = budgetAmount
                break
            }
        }
        var done: Bool = false
        if check {
            done = database.updateValue(tableName: "Budget", columns: budgetDatabaseColumn, values: ["spentAmount": (spentAmount + transasction.amount)], idName: "monthlyAnalysisId", id: monthlyAnalysisId)
        }
        else {
            done = database.addValue(tableName: "Budget", columns: budgetDatabaseColumn, values: values)
        }
        
        if done {
            success("Analysis Added successfully")
        }
        else {
            failure(ZErrorType.parsingFailed)
        }
        
    }
}
