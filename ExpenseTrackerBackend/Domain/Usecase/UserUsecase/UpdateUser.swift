//
//  UpdateUser.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 14/03/23.
//

import Foundation
import VTComponents

public class UpdateUserRequest: ZRequest {
    
    public var user: User
    public var column: String
    public var update: Any
    public init(user: User, column: String, update: Any) {
        self.user = user
        self.column = column
        self.update = update
        super.init(zuid: "")
    }
}

public class UpdateUserResponse: ZResponse {
    
    public var message: String
    public init(message: String) {
        self.message = message
    }
}

public class UpdateUserError: ZError {
    
    public var error: Error
    public init(error: Error) {
        self.error = error
        super.init(status: .unknownError)
    }
}

public class UpdateUser: ZUsecase<UpdateUserRequest, UpdateUserResponse, UpdateUserError> {
    
    var dataManager: UpdateUserDataContract
    public init(dataManager: UpdateUserDataContract) {
        self.dataManager = dataManager
    }
    
    public override func run(request: UpdateUserRequest, success: @escaping (UpdateUserResponse) -> Void, failure: @escaping (UpdateUserError) -> Void) {
        print("in usecase")
        self.dataManager.updateUser(user: request.user, column: request.column, update: request.update) { [weak self] (response) in
            self?.success(callback: success, response: response)
        } failure: { [weak self] (error) in
            self?.failure(callback: failure, error: error)
        }

    }
    
    private func success(callback: @escaping (UpdateUserResponse) -> Void, response: String) {
        invokeSuccess(callback: callback, response: UpdateUserResponse(message: response))
    }
    private func failure(callback: @escaping (UpdateUserError) -> Void, error: Error) {
        invokeFailure(callback: callback, failure: UpdateUserError(error: error))
    }
}
