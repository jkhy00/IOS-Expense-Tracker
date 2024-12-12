//
//  ExpenseCardView.swift
//  ExpenseTracker
//
//  Created by Joshua Yoo on 12/12/24.
//

import SwiftUI

struct ExpenseCardView: View {
    @Bindable var expense: Expense
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(expense.title)
                
                Text(expense.subTitle)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .lineLimit(1)
            
            Spacer(minLength: 5)
            
            Text(expense.currencyString)
                .font(.title3.bold())
        }
    }
}
