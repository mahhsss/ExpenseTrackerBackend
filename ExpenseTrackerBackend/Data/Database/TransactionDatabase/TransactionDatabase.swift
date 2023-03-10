//
//  TransactionDatabase.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 02/03/23.
//

import Foundation

public class TransactionDatabase {
    
    let columnName: [String] = ["transactionId", "userId", "amount", "transactionType", "currencyType", "date", "category", "note"]
    let columnType: [String] = ["integer", "integer", "integer", "text", "text", "datetime", "text", "text"]
    let primaryKey: [String] = ["transactionId"]
    let autoIncrement: [String] = ["transactionId"]
    let uniqueKey: [String] = []
    let database: Database
    public var transactionDatabaseColumn: [Column] = []
    
    init() {
        
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
            self.transactionDatabaseColumn.append(instance)
        }
        database = Database()
        database.createTable(tableName: "\"Transaction\"", columns: transactionDatabaseColumn)
    }
}
