//
//  UserDataManagerContract.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 24/02/23.
//

import Foundation

public protocol AddUserDatabaseContract {
    
    func addUser(user: User, success: @escaping () -> Void, failure: @escaping () -> Void)
}

public protocol GetUserDatabaseContract {
    
    func getUser(success: @escaping ([User]) -> Void, failure: @escaping () -> Void)
}
