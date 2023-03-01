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
    
    func userLogin(emailId: String, password: String, response: @escaping (User) -> Void, failure: @escaping (Error) -> Void)
}
