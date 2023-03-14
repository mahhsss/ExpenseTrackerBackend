//
//  UpdateTransactionDatabase.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 14/03/23.
//

import Foundation
import VTComponents

public class UpdateTranastionDatabaseServise: TransactionDatabase {
    
    public override init() { }
}

extension UpdateTranastionDatabaseServise: UpdateTranasctionDatabaseContract {
    
    public func updateTransaction(user: User, transaction: Transaction, column: String, update: Any, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void) {
        let result = database.updateValue(tableName: "\"Transaction\"", columns: transactionDatabaseColumn, values: [column: update], idName: "transactionId", id: transaction.transactionId)
        
        if result {
            success("Value Updated Successfully")
        }
        else {
            failure(ZErrorType.updateError)
        }
    }
}
