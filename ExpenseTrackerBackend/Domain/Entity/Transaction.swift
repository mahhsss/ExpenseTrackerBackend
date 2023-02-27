//
//  Transaction.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 27/02/23.
//

import Foundation

enum CurrencyType {
    case cash
    case bankTransaction
}

enum TransactionType {
    case spending
    case income
}

public struct Transaction {
    
    var transactionId: String
    var userId: Int
    var amount: Int
    var transactionType: TransactionType
    var currencyType: CurrencyType
    var date: Date
    var note: String
}
