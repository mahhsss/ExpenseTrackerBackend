//
//  Transaction.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 27/02/23.
//

import Foundation

public enum CurrencyType: String {
    case cash = "Cash"
    case bankTransaction = "Bank"
}

public enum TransactionType: String {
    case spending = "Spending"
    case income = "Income"
}

public struct Transaction {
    
    var transactionId: Int
    var userId: Int
    var amount: Int
    var transactionType: TransactionType
    var currencyType: CurrencyType
    var date: String
    var category: String?
    var note: String?
    
    
    public init(transactionId: Int, userId: Int, amount: Int, transactionType: TransactionType, currencyType: CurrencyType, date: String, category: String? = nil, note: String? = nil) {
        self.transactionId = transactionId
        self.userId = userId
        self.amount = amount
        self.transactionType = transactionType
        self.currencyType = currencyType
        self.date = date
        self.category = category
        self.note = note
    }
}
