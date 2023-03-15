//
//  BudgetDatabase.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 15/03/23.
//

import Foundation

public class BudgetDatabase {
    
    let columnName: [String] = ["monthlyAnalysisId", "userId", "budgetAmount", "monthAndYear", "spentAmount"]
    let columnType: [String] = ["integer", "integer", "integer", "datetime", "integer"]
    let primaryKey: [String] = ["monthlyAnalysisId"]
    let autoIncrement: [String] = ["monthlyAnalysisId"]
    let uniqueKey: [String] = []
    let database: Database
    public var budgetDatabaseColumn: [Column] = []
    
    public init() {
        for index in 0 ..< columnName.count {
            
            var isPrimaryKey: Bool = false
            var isAutoIncrement: Bool = false
            var isUniqueKey: Bool = false
            if primaryKey.contains(columnName[index]) {
                isPrimaryKey = true
            }
            if autoIncrement.contains(columnName[index]) {
                isAutoIncrement = true
            }
            if uniqueKey.contains(columnName[index]) {
                isUniqueKey = true
            }
            let instance = Column(name: columnName[index], type: columnType[index], primaryKey: isPrimaryKey, autoIncrement: isAutoIncrement, uniqueKey: isUniqueKey)
            self.budgetDatabaseColumn.append(instance)
        }
        
        database = Database()
        database.createTable(tableName: "Budget", columns: budgetDatabaseColumn, constraint: ", constraint user_budget unique(userId,monthAndYear)")
    }
}
