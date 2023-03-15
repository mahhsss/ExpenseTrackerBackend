//
//  AddCategory.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 27/02/23.
//

import Foundation
import VTComponents

public class AddCategoryRequest: Request {
    
    var user: User
    var category: ExpendatureCategory
    public init(user: User, category: ExpendatureCategory) {
        self.user = user
        self.category = category
    }
}

public class AddCategoryResponse: ZResponse {
    
    public let message: String
    init(message: String) {
        self.message = message
    }
}

public class AddCategoryError: ZError {
    
    public var error: Error
    public init(error: Error) {
        self.error = error
        super.init(status: .unknownError)
    }
}

public class AddCategory: ZUsecase<AddCategoryRequest, AddCategoryResponse, AddCategoryError> {
    
    var dataManager: AddCategoryDataContract
    public init(dataManager: AddCategoryDataContract) {
        self.dataManager = dataManager
    }
    
    public override func run(request: AddCategoryRequest, success: @escaping (AddCategoryResponse) -> Void, failure: @escaping (AddCategoryError) -> Void) {
        dataManager.addCategory(user: request.user, category: request.category) { [weak self] (response) in
            self?.success(callback: success, response: response)
        } failure: { [weak self] (error) in
            self?.failure(error: error, callback: failure)
        }

    }
    
    private func success(callback: @escaping (AddCategoryResponse) -> Void, response: String) {
        invokeSuccess(callback: callback, response: AddCategoryResponse(message: response))
    }
    
    private func failure(error: Error, callback: @escaping (AddCategoryError) -> Void) {
        invokeFailure(callback: callback, failure: AddCategoryError(error: error))
    }
}
