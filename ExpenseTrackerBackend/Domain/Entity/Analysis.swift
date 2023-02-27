//
//  Analysis.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 27/02/23.
//

import Foundation

public struct Analysis {
    var userId: Int
    var weeklyAnalysis: [Transaction]
    var monthlyAnalysis: [Transaction]
    var yearlyAnalysis: [Transaction]
    var dailyAnalysis: [Transaction]
}
