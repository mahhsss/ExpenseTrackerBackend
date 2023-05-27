//
//  GetParticularTypeTransaction.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 25/05/23.
//

import Foundation

public protocol GetMonthlySpentDataProtocol {
    
    func getMonthlySpent(userId: Int, month: String, success: @escaping ([Transaction]) -> Void, failure: @escaping (Error) -> Void)
}

public protocol GetMonthlyIncomeDataProtocol {
    
    func getMonthlyIncome(userId: Int, month: String, success: @escaping ([Transaction]) -> Void, failure: @escaping (Error) -> Void)
}

public protocol GetMonthlyBalanceDataProtocol {
    
    func getMonthlyBalance(userId: Int, month: String, success: @escaping ([Transaction]) -> Void, failure: @escaping (Error) -> Void)
}
