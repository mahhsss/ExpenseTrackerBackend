//
//  UserSignIn.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 24/02/23.
//

import Foundation
import VTComponents


public class UserLoginRequest: ZRequest {
    
    let emailId: String
    let password: String
    public init(emailId: String, password: String) {
        self.emailId = emailId
        self.password = password
        super.init(zuid: " ")
    }
}

public class UserLoginResponse: ZResponse {
    
    let user: User
    init(user: User) {
        self.user = user
    }
}

public class UserLoginError: ZError {
    
    public let error: Error
    public init(error: Error) {
        self.error = error
        super.init(status: .unknownError)
    }

}

public class UserLogin: ZUsecase<UserLoginRequest, UserLoginResponse, UserLoginError> {
    
    
}
