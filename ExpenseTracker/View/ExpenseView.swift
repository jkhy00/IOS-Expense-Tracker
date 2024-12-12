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
