//
//  File.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 06/03/23.
//

import Foundation

public protocol GetCategoryDataProtocol {
    
    func getCategory(user: User, success: @escaping ([ExpendatureCategory]) -> Void, failure: @escaping (Error) -> Void)
}
