//
//  CategoryDatabase.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 06/03/23.
//

import Foundation
import SQLite3
import VTComponents

public class CategoryDatabase {
   
    let columnName: [String] = ["categoryId", "userId", "categoryname"]
    let columnType: [String] = ["integer", "integer", "text"]
    let primaryKey: [String] = ["categoryId"]
    let autoIncrement: [String] = ["categoryId"]
    let uniqueKey: [String] = []
    let database: Database
    public var categoryDatabaseColumn: [Column] = []

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
            self.categoryDatabaseColumn.append(instance)
        }
        
        database = Database()
        database.createTable(tableName: "Category", columns: categoryDatabaseColumn, constraint: ", constraint user_category unique(userId,categoryname)")
    }
}
