//
//  Category.swift
//  ExpenseTracker
//
//  Created by Joshua Yoo on 12/12/24.
//


//
//  Category.swift
//  ExpenseTracker
//
//  Created by Joshua Yoo on 12/12/24.
//

import SwiftUI
import SwiftData

@Model
class Category  {
    var categoryName: String
    @Relationship(deleteRule: .cascade, inverse: \Expense.category)
    var expenses: [Expense]?
    
    init(categoryName: String) {
        self.categoryName = categoryName
    }
}
