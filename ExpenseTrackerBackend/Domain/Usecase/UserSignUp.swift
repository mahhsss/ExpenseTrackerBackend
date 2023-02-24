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
    
    public override init() {
        
    }
}

public class AddNewUserError: ZError {
    
}

public class AddNewUser: ZUsecase<AddNewUserRequest, AddnewUserResponse, AddNewUserError> {
    
    var dataManager: AddUserDataContract
    public var response: AddnewUserResponse?
    
    public init(dataManager: AddUserDataContract) {
        self.dataManager = dataManager
    }
    
    public override func run(request: AddNewUserRequest, success: @escaping (AddnewUserResponse) -> Void, failure: @escaping (AddNewUserError) -> Void) {
        dataManager.addUser(user: request.user) { [weak self] () in
            self?.success(callback: success)
        } failure: { [weak self] (error) in
            self?.failure(error: error, callback: failure)
        }

    }
    
    func success(callback: @escaping (AddnewUserResponse) -> Void) {
        self.response = AddnewUserResponse()
        invokeSuccess(callback: callback, response: self.response!)
    }
    
    func failure(error: AddNewUserError, callback: @escaping (AddNewUserError) -> Void) {
        invokeFailure(callback: callback, failure: error)
    }
}
