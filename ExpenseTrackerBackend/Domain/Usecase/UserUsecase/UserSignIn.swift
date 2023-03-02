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
    
    public let user: User
    public init(user: User) {
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
    
    var dataManager: UserLoginDataContract
    var response: UserLoginResponse?
    var error: UserLoginError?
    public init(dataManager: UserLoginDataContract) {
        self.dataManager = dataManager
    }
    
    public override func run(request: UserLoginRequest, success: @escaping (UserLoginResponse) -> Void, failure: @escaping (UserLoginError) -> Void) {
        dataManager.userLogin(emailId: request.emailId, password: request.password) { [weak self] response in
            self?.success(callBack: success, response: response)
        } failure: { [weak self] error in
            self?.failure(callBack: failure, error: error)
        }

    }
    
    public func success(callBack: @escaping (UserLoginResponse) -> Void, response: User) {
        self.response = UserLoginResponse(user: response)
        invokeSuccess(callback: callBack, response: self.response!)
    }
    
    public func failure(callBack: @escaping (UserLoginError) -> Void, error: Error) {
        let error = UserLoginError(error: error)
        invokeFailure(callback: callBack, failure: error)
    }
}

