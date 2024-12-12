import SwiftUI
import SwiftData

struct ExpenseView: View {
    @Query(sort: [
        SortDescriptor(\Expense.date, order: .reverse)
    ], animation: .snappy) private var allExpenses: [Expense]
    @Environment(\.modelContext) private var context
    
    @State private var groupedExpenses: [GroupedExpenses] = []
    @State private var addExpense: Bool = false
    
    // Compute the total spending from all expenses
    var totalSpending: Double {
        allExpenses.reduce(0) { $0 + $1.amount } // Assuming "amount" is the property for expense cost
    }
    
    var body: some View {
        NavigationStack {
            List {
                // Display total spending at the top of the list
                Section {
                    HStack {
                        Text("Total Spending")
                            .font(.title2)
                            .bold()
                        
                        Spacer()
                        
                        Text("$\(totalSpending, specifier: "%.2f")")
                            .font(.title2)
                            .foregroundColor(.red) // You can customize the color
                    }
                    .padding()
                }
                
                // Display all expenses
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
            }
            .navigationTitle("Expenses")
            .overlay {
                if allExpenses.isEmpty {
                    ContentUnavailableView {
                        Label("No Expenses", systemImage: "tray.fill")
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
            .sheet(isPresented: $addExpense) {
                AddExpenseView()
            }
        }
    }
}

#Preview {
    ExpenseView()
}


//        .onChange(of: allExpenses, initial: true) { oldValue, newValue in
       //            if newValue.count > oldValue.count || groupedExpenses.isEmpty {
       //                createGroupedExpenses(newValue)
       //            }
       //        }
//       .sheet(isPresented: $addExpense) {
//           AddExpenseView()
//       }
//   }
   
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
