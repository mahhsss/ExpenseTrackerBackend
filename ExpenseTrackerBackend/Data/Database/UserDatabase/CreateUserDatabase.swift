//
//  CreateUserDatabase.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 24/02/23.
//

import Foundation

public class UserDatabase {
    
    let columnName: [String] = ["userId", "name", "emailId", "password"]
    let columnType: [String] = ["integer", "text", "text", "text"]
    let primaryKey: [String] = ["userId"]
    let autoIncrement: [String] = ["userId"]
    let database: Database
    public var userDatabaseColumn: [Column] = []
    
    init() {
        
        for index in 0 ..< columnName.count {
            
            var isPrimaryKey: Bool = false
            var isAutoIncrement: Bool = false
            if primaryKey.contains(columnName[index]) {
                isPrimaryKey = true
            }
            if autoIncrement.contains(columnName[index]) {
                isAutoIncrement = true
            }
            let instance = Column(name: columnName[index], type: columnType[index], primaryKey: isPrimaryKey, autoIncrement: isAutoIncrement)
            self.userDatabaseColumn.append(instance)
        }
        database =  Database.openDatabase()
        database.createTable(tableName: "User", columns: userDatabaseColumn)
    }
}
