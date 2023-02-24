//
//  AddUserContract.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 24/02/23.
//

import Foundation

public protocol AddUserDataContract {
    func addUser(user: User, success: @escaping () -> Void, failure: @escaping (AddNewUserError) -> Void)
}
