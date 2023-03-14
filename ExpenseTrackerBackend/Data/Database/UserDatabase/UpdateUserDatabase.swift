//
//  UpdateUserDatabase.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 14/03/23.
//

import Foundation
import VTComponents

public class UpdateUserDatabase: UserDatabase {
    
    public override init() { }
}

extension UpdateUserDatabase: UpdateUserDatabaseContract {
    
    public func updateUser(user: User, column: String, update: Any, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void) {
        print("in database")
        let result = database.updateValue(tableName: "User", columns: userDatabaseColumn, values: [column: update], idName: "userId", id: user.userId)
        if result {
            success("\(column) is changed to \(update)")
        }
        else {
            failure(ZErrorType.updateError)
        }
    }
}
