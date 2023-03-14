//
//  Database.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 24/02/23.
//

import Foundation
import SQLite3
import VTComponents


public struct Column {
    let name: String
    let type: String
    var primaryKey: Bool = false
    var autoIncrement: Bool = false
    var uniqueKey: Bool = false
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
    
    init() {
        
        if dbPointer == nil {
            do {
                var filePath = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                filePath.append(path: "ExpenseTracker")
                try FileManager.default.createDirectory(at: filePath, withIntermediateDirectories: true,attributes: [:])
                filePath.append(path: "ExpenseTracker.sqlite")
                Database.filepath = filePath.path()
                if sqlite3_open(Database.filepath, &dbPointer) == SQLITE_OK {
                    if dbPointer != nil {
                        print("            Opened DB \n")
                    }
                }
                
            } catch let error {
                print("   -*- \(error) -*-   ")
            }
            
        }
    }
    
    deinit {
        print("Closing DB")
        sqlite3_close_v2(dbPointer)
    }
    
}

extension Database {
    
    private func prepareStatement(query: String) -> OpaquePointer? {
        
        var statementPointer: OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &statementPointer, nil) == SQLITE_OK {
            return statementPointer
        } else {
            print("            Error in preparing the statement")
        }
        return statementPointer
    }
    
    func createTable(tableName: String, columns: [Column], constraint: String? = nil) {
        var tableTypes: String = ""
        for column in columns {
            tableTypes += column.name + " \(column.type)"
            if column.primaryKey == true {
                tableTypes += " PRIMARY KEY"
            }
            if column.autoIncrement == true {
                tableTypes += " AUTOINCREMENT"
            }
            if column.uniqueKey == true {
                tableTypes += " UNIQUE"
            }
            tableTypes += ", "
        }
        var tableQuery = ""
        if constraint != nil {
            tableQuery  = "CREATE TABLE IF NOT EXISTS " + tableName + " (" + tableTypes.dropLast(2) + String(constraint!) + ")"
        }
        else {
            tableQuery = "CREATE TABLE IF NOT EXISTS " + tableName + " (" + tableTypes.dropLast(2) + ")"
        }
        
        let createTableStatement = prepareStatement(query: tableQuery)
        if sqlite3_step(createTableStatement) == SQLITE_DONE {
            print("            Created Table \n")
        } else {
            print("Error in creating Table")
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
            if column.type == "text" || column.type == "datetime" {
                if values[column.name] != nil {
                    columnValue += "\"" + String(values[column.name] as! String) + "\", "
                }
                else {
                    columnValue += "\"" + "nil" + "\", "
                }
            }
            else if column.type == "integer" {
                columnValue += String(values[column.name] as! Int) + ", "
            }
        }
        let query = "INSERT INTO " +  tableName + "(\(columnNames.dropLast(2))) " + " VALUES(\(columnValue.dropLast(2)))"
        let createTableStatement = prepareStatement(query: query)
        if sqlite3_step(createTableStatement) == SQLITE_DONE {
            return true
        } else {
            return false
        }
    }
    
    func getData(tableName: String, column: [Column], columnName: String, columnValue: String) -> [String: Any] {
        var query = "SELECT * FROM " + tableName
        if columnName != "" {
            query += " WHERE " + columnName + " = \"" + columnValue + "\""
        }
        var selectStatement: OpaquePointer?
        var result: [String: Any] = [:]
        if sqlite3_prepare(self.dbPointer, query, -1, &selectStatement, nil) == SQLITE_OK {
            if sqlite3_step(selectStatement) == SQLITE_ROW {
                for (index,col) in column.enumerated() {
                    if col.type == "integer" {
                        result[col.name] = Int(sqlite3_column_int(selectStatement, Int32(index)))
                    }
                    else if col.type == "text" || col.type == "datetime" {
                        result[col.name] = String(cString: sqlite3_column_text(selectStatement, Int32(index))!)
                    }
                }
            }
            sqlite3_finalize(selectStatement)
        }
        return result
    }
    
    func getArrayData(tableName: String, column: [Column], columnName: String?, columnValue: Int?) -> [[String: Any]] {
        var query = "SELECT * FROM " + tableName
        if let columnName = columnName {
            query += " WHERE " + columnName + " = \"" + "\(columnValue!)" + "\""
        }
        var selectStatement: OpaquePointer?
        var result: [[String: Any]] = []
        if sqlite3_prepare(self.dbPointer, query, -1, &selectStatement, nil) == SQLITE_OK {
            while sqlite3_step(selectStatement) == SQLITE_ROW {
                var rowValue: [String: Any] = [: ]
                for (index,col) in column.enumerated() {
                    if col.type == "integer" {
                        rowValue[col.name] = Int(sqlite3_column_int(selectStatement, Int32(index)))
                    }
                    else if col.type == "text" || col.type == "datetime" {
                        rowValue[col.name] = String(cString: sqlite3_column_text(selectStatement, Int32(index))!)
                    }
                }
                result.append(rowValue)
                
            }
            sqlite3_finalize(selectStatement)
        }
        return result
    }
    
    func getTransactionAnalysis(tableName: String, column: [Column], columnName: String?, columnValue1: String?, columnValue2: String?, userId: Int?) -> [[String: Any]] {
        var query = "SELECT * FROM " + tableName
        if let columnName = columnName {
            query += " WHERE " + ("\"\(columnName)\"") + " > " + ("\"\(columnValue1!)\"") + " AND " + ("\"\(columnName)\"") + " < " + ("\"\(columnValue2!)\"") + " AND " + (" userId = ") + ("\"\(userId!)\"")
        }
        var selectStatement: OpaquePointer?
        var result: [[String: Any]] = []
        if sqlite3_prepare(self.dbPointer, query, -1, &selectStatement, nil) == SQLITE_OK {
            while sqlite3_step(selectStatement) == SQLITE_ROW {
                var rowValue: [String: Any] = [: ]
                for (index,col) in column.enumerated() {
                    if col.type == "integer" {
                        rowValue[col.name] = Int(sqlite3_column_int(selectStatement, Int32(index)))
                    }
                    else if col.type == "text" || col.type == "datetime" {
                        rowValue[col.name] = String(cString: sqlite3_column_text(selectStatement, Int32(index))!)
                    }
                }
                result.append(rowValue)
                
            }
            sqlite3_finalize(selectStatement)
        }
        return result
    }
    
    func updateValue(tableName: String, columns: [Column], values: [String: Any], idName: String, id: Int, IncrementValue: Int = 0) -> Bool {
        
        var columnValue: String = ""
        for column in columns {
            if values[column.name] != nil {
                if column.type == "text" {
                    columnValue += column.name + " = " + "'" + String(values[column.name] as! String) + "'" + ", "
                }
                else if column.type == "integer" {
                    if IncrementValue != 0 {
                        columnValue += column.name + " = " + column.name + " + " + String(IncrementValue)
                    }
                    else {
                        columnValue += column.name + " = " + String(values[column.name] as! Int)
                    }
                    columnValue += ", "
                }
                
            }
        }
        let query = "UPDATE \(tableName) SET \(columnValue.dropLast(2)) WHERE \(idName) = \(id) "
        if sqlite3_exec(self.dbPointer, query, nil, nil, nil) == SQLITE_OK {
            return true
        }
        else {
            return false
        }
    }

    
}

