//
//  User.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 24/02/23.
//

import Foundation

public struct User {
    
    public var userId: Int
    public var name: String
    public var emailId: String
    var password: String
    
    public init(userId: Int, name: String, emailId: String, password: String) {
        self.userId = userId
        self.name = name
        self.emailId = emailId
        self.password = password
    }
}
