//
//  GetCategoryDataManager.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 06/03/23.
//

import Foundation

public class GetCategoryDataManagerServise: GetCategoryDataProtocol {
    
    
    var database: GetCategoryDatabaseContract
    public init(database: GetCategoryDatabaseContract) {
        self.database = database
    }
    
    public func getCategory(userId: Int, success: @escaping ([ExpendatureCategory]) -> Void, failure: @escaping (Error) -> Void) {
        database.getCategory(userId: userId) { [weak self] (response) in
            self?.success(callback: success, response: response)
        } failure: { [weak self] (error) in
            self?.failure(callback: failure, error: error)
        }
    }
    
    
    private func success(callback: ([ExpendatureCategory]) -> Void, response: [ExpendatureCategory]) {
        callback(response)
    }
    
    private func failure(callback: (Error) -> Void, error: Error) {
        callback(error)
    }
}
