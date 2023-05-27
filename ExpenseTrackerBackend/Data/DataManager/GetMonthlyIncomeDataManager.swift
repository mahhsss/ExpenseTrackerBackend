//
//  GetMonthlyIncomeDataManager.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 26/05/23.
//

import Foundation


public class GetMonthlyIncomeDataManager: GetMonthlyIncomeDataProtocol {
    
    var database: GetMonthlyIncomeDatabaseContract
    
    public init(database: GetMonthlyIncomeDatabaseContract) {
        self.database = database
    }
    
    public func getMonthlyIncome(userId: Int, month: String, success: @escaping ([Transaction]) -> Void, failure: @escaping (Error) -> Void) {
        self.database.getmonthlyIncome(userId: userId, month: month) { [weak self] (response) in
            self?.success(callback: success, response: response)
        } failure: { [weak self] (error) in
            self?.failure(callback: failure, error: error)
        }
    }
    
    private func success(callback: ([Transaction]) -> Void, response: [Transaction]) {
        callback(response)
    }
    
    private func failure(callback: (Error) -> Void, error: Error) {
        callback(error)
    }
    
}
