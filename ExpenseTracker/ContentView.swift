//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Joshua Yoo on 12/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var currentTab: String = "Expenses"
    var body: some View {
        TabView(selection: $currentTab) {
            LogoPageView()
                .tag("LOGO")
                .tabItem {
                    Image(systemName: "square.and.pencil.circle")
                    Text("LOGO")
                }
            ExpenseView()
                .tag("Expenses")
                .tabItem {
                    Image(systemName: "creditcard.fill")
                    Text("Expenses")
                }
            CategoryView()
                .tag("Categories")
                .tabItem {
                    Image(systemName: "creditcard.fill")
                    Text("Categories")
                }
        }
    }
}

#Preview {
    ContentView()
}
