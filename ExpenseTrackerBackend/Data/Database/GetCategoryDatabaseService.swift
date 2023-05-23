//
//  GetCategoryDatabaseServise.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 06/03/23.
//

import Foundation
import VTComponents
import SQLite3

public class GetCategoryDatabaseService: CategoryDatabase {
    
    public override init() { }
}

extension GetCategoryDatabaseService: GetCategoryDatabaseContract {
    
    public func getCategory(userId: Int, success: @escaping ([ExpendatureCategory]) -> Void, failure: @escaping (Error) -> Void) {
        
        let result = database.getArrayData(tableName: "Category", column: categoryDatabaseColumn, columnName: "userId", columnValue: userId)
        var categories: [ExpendatureCategory] = []
        for row in result {
            
            let category = ExpendatureCategory(categoryId: row["categoryId"] as! Int , userId: row["userId"] as! Int, categoryname: row["categoryname"] as! String)
            categories.append(category)
        }
        if !categories.isEmpty {
            success(categories)
        }
        else {
            failure(ZErrorType.dataNotFound)
        }
    }
}
