//
//  Budget.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 15/03/23.
//

import Foundation

public struct Budget {
    
    public var budget: Int
    public var month: String
    public init(budget: Int, month: String) {
        self.budget = budget
        self.month = month
    }
}
