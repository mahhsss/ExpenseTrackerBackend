//
//  UserDataManagerContract.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 24/02/23.
//

import Foundation

public protocol AddUserDatabaseContract {
    
    func addUser(user: User, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void)
}

public protocol GetUserDatabaseContract {
    
    func getUser(success: @escaping ([User]) -> Void, failure: @escaping () -> Void)
}
