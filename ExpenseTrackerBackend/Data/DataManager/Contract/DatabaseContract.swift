//
//  UserDataManagerContract.swift
//  ExpenseTrackerBackend
//
//  Created by mahesh-pt6305 on 24/02/23.
//

import Foundation

//---------------------------------------- User Database Contract --------------------------------------------
public protocol AddUserDatabaseContract {
    func addUser(user: User, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void)
}

public protocol GetUserDatabaseContract {
    func getUser(emailId: String, password: String, response: @escaping (User) -> Void, failure: @escaping (Error) -> Void )
}

public protocol UpdateUserDatabaseContract {
    func updateUser(user: User, column: String, update: Any, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void)
}
//------------------------------------------------------------------------------------------------------------

//---------------------------------- Tranasction Database contract -------------------------------------------
public protocol GetAllTransactionDatabaseContract {
    func getTransaction(userId: Int, success: @escaping ([Transaction]) -> Void, failure: @escaping (Error) -> Void)
}

public protocol AddTransactionDatabaseContract {
    
    func addTransaction(userId: Int, transaction: Transaction, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void)
}

public protocol UpdateTranasctionDatabaseContract {
    
    func updateTransaction(userId: Int, transaction: Transaction, column: String, update: Any, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void)
}

public protocol DeleteTransactionDatabaseContract {
    func deleteTransaction(userId: Int, transaction: Transaction, columnName: String, columnValue: Any, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void)
}

public protocol GetMonthlySpentDatabaseContract {
    
    func getMonthlySpent(userId: Int, month: String, success: @escaping ([Transaction]) -> Void, failure: @escaping (Error) -> Void)
}

public protocol GetMonthlyIncomeDatabaseContract {
    
    func getmonthlyIncome(userId: Int, month: String, success: @escaping ([Transaction]) -> Void, failure: @escaping (Error) -> Void)
}

public protocol GetMonthlyBalanceDatabaseContract {
    
    func getMonthlyBalance(userId: Int, month: String, success: @escaping ([Transaction]) -> Void, failure: @escaping (Error) -> Void)
}
//------------------------------------------------------------------------------------------------------------

//------------------------------------ Budget Database contract ----------------------------------------------
public protocol AddBudgetDatabaseContract {
    func addBudget(userId: Int, budget: Budget, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void)
}
//------------------------------------------------------------------------------------------------------------

//------------------------------------ MonthlyAnalysis Database contract --------------------------------------
public protocol AddMonthlyAnalysisTransactionDatabaseContract {
    func addMonthlyAnalysisTransaction(userId: Int, transasction: Transaction, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void)
}
//-------------------------------------------------------------------------------------------------------------

//------------------------------------ Category Database contract --------------------------------------------
public protocol GetCategoryDatabaseContract {
    
    func getCategory(userId: Int, success: @escaping ([ExpendatureCategory]) -> Void, failure: @escaping (Error) -> Void)
}

public protocol AddCategoryDatabaseContract {
    
    func addCategory(userId: Int, category: ExpendatureCategory, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void)
}
//------------------------------------------------------------------------------------------------------------

//---------------------------------- Analysis Database contract -------------------------------------------
public protocol GetTransactionAnalysisDatabaseContract {
    func getTransactionAnalysis(userId: Int, startDate: String, endDate: String, success: @escaping ([Transaction]) -> Void, failure: @escaping (Error) -> Void)
}
