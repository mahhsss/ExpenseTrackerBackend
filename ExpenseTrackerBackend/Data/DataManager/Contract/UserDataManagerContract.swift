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
    func getTransaction(user: User, success: @escaping ([Transaction]) -> Void, failure: @escaping (Error) -> Void)
}

public protocol AddTransactionDatabaseContract {
    
    func addTransaction(user: User, transaction: Transaction, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void)
}
public protocol UpdateTranasctionDatabaseContract {
    
    func updateTransaction(user: User, transaction: Transaction, column: String, update: Any, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void)
}
//------------------------------------------------------------------------------------------------------------

//---------------------------------- Category Database contract -------------------------------------------
public protocol GetCategoryDatabaseContract {
    
    func getCategory(user: User, success: @escaping ([ExpendatureCategory]) -> Void, failure: @escaping (Error) -> Void)
}

public protocol AddCategoryDatabaseContract {
    
    func addCategory(user: User, category: ExpendatureCategory, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void)
}
//------------------------------------------------------------------------------------------------------------

//---------------------------------- Analysis Database contract -------------------------------------------
public protocol GetTransactionAnalysisDatabaseContract {
    func getTransactionAnalysis(user: User, startDate: String, endDate: String, success: @escaping ([Transaction]) -> Void, failure: @escaping (Error) -> Void)
}
