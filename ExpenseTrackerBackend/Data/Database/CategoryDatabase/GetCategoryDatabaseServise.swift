//
//  GetCategoryDatabaseServise.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 06/03/23.
//

import Foundation
import VTComponents
import SQLite3

public class GetCategoryDatabaseServise: CategoryDatabase {
    
    public override init() { }
}

extension GetCategoryDatabaseServise: GetCategoryDatabaseContract {
    
    public func getCategory(user: User, success: @escaping ([ExpendatureCategory]) -> Void, failure: @escaping (Error) -> Void) {
        
        let result = database.getArrayData(tableName: "ExpendatureCategory", column: categoryDatabaseColumn)
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
