//
//  File.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 06/03/23.
//

import Foundation

public protocol GetCategoryDataProtocol {
    
    func getCategory(userId: Int, success: @escaping ([ExpendatureCategory]) -> Void, failure: @escaping (Error) -> Void)
}

public protocol AddCategoryDataContract {
    
    func addCategory(userId: Int, category: ExpendatureCategory, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void)
}
