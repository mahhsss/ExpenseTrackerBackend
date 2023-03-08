//
//  AddTransactionDatabaseService.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 07/03/23.
//

import Foundation
import VTComponents

public class AddCategoryDatabaseService: CategoryDatabase {
    
    public override init() { }
}

extension AddCategoryDatabaseService: AddCategoryDatabaseContract {
    
    public func addCategory(user: User, category: ExpendatureCategory, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void) {
        var value: [String: Any] = [:]
        value["categoryId"] = category.categoryId
        value["userId"] = user.userId
        value["categoryname"] = category.categoryname
        let result = database.addValue(tableName: "Category", columns: categoryDatabaseColumn, values: value)
        
        if result {
            success("Category Added Successfully")
        }
        else {
            failure(ZErrorType.unknownError)
        }
    }
}
