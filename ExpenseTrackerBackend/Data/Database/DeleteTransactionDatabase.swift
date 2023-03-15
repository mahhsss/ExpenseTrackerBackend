//
//  DeleteTransactionDatabase.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 14/03/23.
//

import Foundation
import VTComponents


public class DeleteTransactionDatabaseService: TransactionDatabase {
    
    public override init() { }
}

extension DeleteTransactionDatabaseService: DeleteTransactionDatabaseContract {
 
    public func deleteTransaction(user: User, transaction: Transaction, columnName: String, columnValue: Any, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void) {
        let result = database.deleteValue(tableName: "\"Transaction\"", columnName: columnName, columnValue: columnValue)
        if result {
            success("Value Deleted Successfully")
        }
        else {
            failure(ZErrorType.updateError)
        }
    }
    

}
