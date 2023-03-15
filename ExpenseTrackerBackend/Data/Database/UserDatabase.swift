//
//  CreateUserDatabase.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 24/02/23.
//

import Foundation
import SQLite3
import VTComponents

//public class UserDatabase {
//
//}

public class UserDatabase {
    
    let columnName: [String] = ["userId", "name", "emailId", "password"]
    let columnType: [String] = ["integer", "text", "text", "text"]
    let primaryKey: [String] = ["userId"]
    let autoIncrement: [String] = ["userId"]
    let uniqueKey: [String] = ["emailId"]
    let database: Database
    public var userDatabaseColumn: [Column] = []
    
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
            self.userDatabaseColumn.append(instance)
        }
        database =  Database()
        database.createTable(tableName: "User", columns: userDatabaseColumn)
    }
}
