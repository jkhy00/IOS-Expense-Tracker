//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Joshua Yoo on 12/12/24.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        
        .modelContainer(for: [Expense.self, Category.self])
        
    }
}
