//
//  GetCategoryUsecase.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 27/02/23.
//

import Foundation
import VTComponents

public class GetCategoryRequest: Request {
    
    var user: User
    public init(user: User) {
        self.user = user
    }
}

public class GetCategoryResponse: ZResponse {
    
    public let category: [ExpendatureCategory]
    public init(category: [ExpendatureCategory]) {
        self.category = category
    }
}

public class GetCategoryError: ZError {
    
    public var error: Error
    public init(error: Error) {
        self.error = error
        super.init(status: .unknownError)
    }
}

public class GetCategory: ZUsecase<GetCategoryRequest, GetCategoryResponse, GetCategoryError> {
    
    var dataManager: GetCategoryDataProtocol
    
    public init(dataManager: GetCategoryDataProtocol) {
        self.dataManager = dataManager
    }
    
    public override func run(request: GetCategoryRequest, success: @escaping (GetCategoryResponse) -> Void, failure: @escaping (GetCategoryError) -> Void) {
        dataManager.getCategory(user: request.user) { [weak self] (response) in
            self?.success(callback: success, response: response)
        } failure: { [weak self] (error) in
            self?.failure(callback: failure, error: error)
        }

    }
    
    private func success(callback: @escaping (GetCategoryResponse) -> Void, response: [ExpendatureCategory]) {
        
        invokeSuccess(callback: callback, response: GetCategoryResponse(category: response))
    }
    
    private func failure(callback: @escaping (GetCategoryError) -> Void, error: Error) {
        invokeFailure(callback: callback, failure: GetCategoryError(error: error))
    }
}
