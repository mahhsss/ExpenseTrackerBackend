//
//  UserSignUp.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 24/02/23.
//

import Foundation
import VTComponents

public class AddNewUserRequest: ZRequest {
    
    var user: User
    public init(user: User) {
        self.user = user
        super.init(zuid: " ")
    }
}

public class AddnewUserResponse: ZResponse {
    
    public let message : String
    init(message: String) {
        self.message = message
    }
}

public class AddNewUserError: ZError {
    
    public let error: Error
    public init(error: Error) {
        self.error = error
        super.init(status: .unknownError)
    }

}

public class AddNewUser: ZUsecase<AddNewUserRequest, AddnewUserResponse, AddNewUserError> {
    
    var dataManager: AddUserDataContract
    public var response: AddnewUserResponse?
    
    public init(dataManager: AddUserDataContract) {
        self.dataManager = dataManager
    }
    
    public override func run(request: AddNewUserRequest, success: @escaping (AddnewUserResponse) -> Void, failure: @escaping (AddNewUserError) -> Void) {
        
        dataManager.addUser(user: request.user) { [weak self] (response) in
            self?.success(callback: success, response: response)
        } failure: { [weak self] (error) in
            self?.failure(error: error, callback: failure)
        }

    }
    
    func success(callback: @escaping (AddnewUserResponse) -> Void, response: String) {
        self.response = AddnewUserResponse(message: response)
        invokeSuccess(callback: callback, response: self.response!)
    }
    
    func failure(error: Error, callback: @escaping (AddNewUserError) -> Void) {
        let error = AddNewUserError(error: error)
        invokeFailure(callback: callback, failure: error)
    }
}
