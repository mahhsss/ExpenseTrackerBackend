//
//  AddUserContract.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 24/02/23.
//

import Foundation

public protocol AddUserDataContract {
    func addUser(user: User, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void)
}

public protocol UserLoginDataContract {
    
    func userLogin(emailId: String, password: String, success: @escaping (User) -> Void, failure: @escaping (Error) -> Void)
}

public protocol UpdateUserDataContract {
    func updateUser(user: User, column: String, update: Any, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void)
}
