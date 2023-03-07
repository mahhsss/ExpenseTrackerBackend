//
//  Category.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 27/02/23.
//

import Foundation

public struct ExpendatureCategory {
    
    public var categoryId: Int
    public var userId: Int
    public var categoryname: String
    
    public init(categoryId: Int, userId: Int, categoryname: String) {
        self.categoryId = categoryId
        self.userId = userId
        self.categoryname = categoryname
    }
}
