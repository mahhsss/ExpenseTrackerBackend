//
//  Database.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 24/02/23.
//

import Foundation
import SQLite3


public struct Column {
    let name: String
    let type: String
    var primaryKey: Bool = false
    var autoIncrement: Bool = false
}

public class Database {
    
    var dbPointer: OpaquePointer?
    static var filepath: String = ""
    var errorMsg: String {
        get {
            // Give the recent errormsg
            if let error = sqlite3_errmsg(dbPointer) {
                let errorMsg = String(cString: error)
                return errorMsg
            } else {
                return "No error message recieved"
            }
        }
    }
    
    private init(dbPointer: OpaquePointer) {
        self.dbPointer = dbPointer
        do {
            var filePath = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            filePath.append(path: "ExpenseTracker")
            try FileManager.default.createDirectory(at: filePath, withIntermediateDirectories: true,attributes: [:])
            filePath.append(path: "User.sqlite")
            Database.filepath = filePath.path()
            
        } catch let error {
            print("   -*- \(error) -*-   ")
        }
    }
    
    deinit {
        print("Closing DB")
        sqlite3_close_v2(dbPointer)
    }
    
    static func openDatabase() -> Database {

        var db: OpaquePointer?

        if sqlite3_open(filepath, &db) == SQLITE_OK {
            print("Opened DB \(filepath)")
            if let db = db {
                return Database(dbPointer: db)
            }
        }
        else {
            print("Error in creating Database")
        }
        return Database(dbPointer: db!)
    }
    
    private func prepareStatement(query: String) -> OpaquePointer? {

        var statementPointer: OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &statementPointer, nil) == SQLITE_OK {
            return statementPointer
        } else {
            print("Error in preparing the statement")
        }
        return statementPointer
    }
    
    func createTable(tableName: String, columns: [Column]) {
        var tableTypes: String = ""
        for column in columns {
            tableTypes += column.name + " \(column.type)"
            if column.primaryKey == true {
                tableTypes += " PRIMARY KEY"
            }
            if column.autoIncrement == true {
                tableTypes += " AUTOINCREMENT"
            }
            tableTypes += ", "
            
            let tableQuery = "CREATE TABLE IF NOT EXISTS " + tableName + " (" + tableTypes.dropLast(2) + ")"
            var createTableStatement = prepareStatement(query: tableQuery)
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Created Table")
            } else {
                print("Error in creating Table")
            }
            
        }
    }
    
    func addValue(tableName: String, columns: [Column], values: [String: Any]) -> Bool {
        var columnNames: String = ""
        var columnValue: String = ""
        for column in columns {
            if column.autoIncrement == true {
                continue
            }
            columnNames += column.name + ", "
            if column.type == "TEXT" {
                columnValue += "\"" + String(values[column.name] as! String) + "\", "
            }
            else if column.type == "INTEGER" {
                columnValue += String(values[column.name] as! Int) + ", "
            }
        }
        
        let query = "INSERT INTO " +    tableName + "(\(columnNames.dropLast(2))) " + " VALUES(\(columnValue.dropLast(2)))"
        var createTableStatement = prepareStatement(query: query)
        if sqlite3_step(createTableStatement) == SQLITE_DONE {
            return true
        } else {
            print("Error in creating Table")
            return false
        }
    }
    
}

