//
//  AnalysisDataContract.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 10/03/23.
//

import Foundation


public protocol GetTransactionAnalysisDataContract {
    func getTransactionAnalysis(userId: Int, startDate: String, endDate: String, success: @escaping ([Transaction]) -> Void, failure: @escaping (Error) -> Void)
}
