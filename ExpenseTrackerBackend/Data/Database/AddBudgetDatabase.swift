//
//  AddBudgetDatabase.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 15/03/23.
//

import Foundation
import VTComponents

public class AddBudgetDatabaseService: BudgetDatabase {
 
    public override init() { }
}

extension AddBudgetDatabaseService: AddBudgetDatabaseContract {
    
    public func addBudget(userId: Int, budget: Budget, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void) {
        var values: [String: Any] = [:]
        values["monthlyAnalysisId"] = 0
        values["userId"] = userId
        values["budgetAmount"] = budget.budget
        values["monthAndYear"] = budget.month
        values["spentAmount"] = 0
        let result = database.getArrayData(tableName: "Budget", column: budgetDatabaseColumn, columnName: "userId", columnValue: userId)
        var check: Bool = false
        var monthlyAnalysisId = 0
        for row in result {
            if row["monthAndYear"] as! String == budget.month {
                check = true
                monthlyAnalysisId = row["monthlyAnalysisId"] as! Int
            }
        }
        var done: Bool = false
        if check {
            done = database.updateValue(tableName: "Budget", columns: budgetDatabaseColumn, values: ["budgetAmount": budget.budget], idName: "monthlyAnalysisId", id: monthlyAnalysisId)
        }
        else {
            done = database.addValue(tableName: "Budget", columns: budgetDatabaseColumn, values: values)
        }
        
        if done {
            success("value added successfully")
        }
        else {
            failure(ZErrorType.parsingFailed)
        }
    }
}
