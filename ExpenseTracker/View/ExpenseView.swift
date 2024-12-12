//
//  ExpenseView.swift
//  ExpenseTracker
//
//  Created by Joshua Yoo on 12/12/24.
//

import SwiftUI
import SwiftData

struct ExpenseView: View {
    @Query(sort: [
        SortDescriptor(\Expense.date, order: .reverse)
    ], animation: .snappy) private var allExpenses: [Expense]
    @Environment(\.modelContext) private var context
    
    @State private var groupedExpenses: [GroupedExpenses] = []
    @State private var addExpense: Bool = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(allExpenses, id: \.id) { expense in
                    ExpenseCardView(expense: expense)
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button {
                                withAnimation {
                                    context.delete(expense)
                                }
                            } label: {
                                Image(systemName: "trash")
                            }
                            .tint(.red)
                        }
                }
                .navigationTitle("Expenses")
                .overlay{
                    if allExpenses.isEmpty {
                        ContentUnavailableView {
                            Label("No Expenses", systemImage: "tray.fill")
                        }
                    }
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        addExpense.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                    }
                }
            }
            //        .onChange(of: allExpenses, initial: true) { oldValue, newValue in
            //            if newValue.count > oldValue.count || groupedExpenses.isEmpty {
            //                createGroupedExpenses(newValue)
            //            }
            //        }
            .sheet(isPresented: $addExpense) {
                AddExpenseView()
            }
        }
        
        //    func createGroupedExpenses(_ expenses: [Expense]) {
        //        Task.detached(priority: .high) {
        //            let groupedDict = Dictionary(grouping: expenses) { expense in
        //                let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: expense.date)
        //                return dateComponents
        //            }
        //            let sortedDict = groupedDict.sorted {
        //                let calendar = Calendar.current
        //                let date1 = calendar.date(from: $0.key) ?? .init()
        //                let date2 = calendar.date(from: $1.key) ?? .init()
        //
        //                return calendar.compare(date1, to: date2, toGranularity: .day) == .orderedDescending
        //            }
        //
        //            await MainActor.run {
        //                groupedExpenses = sortedDict.compactMap({ dict in
        //                    let date = Calendar.current.date(from: dict.key) ?? .init()
        //                    return .init(date: date, expenses: dict.value)
        //                })
        //            }
        //        }
        //    }
    }
}


#Preview {
    ExpenseView()
}
