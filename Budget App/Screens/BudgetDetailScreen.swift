//
//  BudgetDetailScreen.swift
//  Budget App
//
//  Created by Anup Saud on 2024-09-11.
//

import SwiftUI

struct BudgetDetailScreen: View {
    let budget: Budget
    
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(sortDescriptors: []) private var expenses: FetchedResults<Expense>
    
    init(budget: Budget){
        self.budget = budget
        _expenses = FetchRequest(sortDescriptors: [],predicate: NSPredicate(format: "budget == %@", budget))
    }
    
    @State private var title: String = ""
    @State private var amount:Double?
    @State private var errorMessage = ""
    @State private var selectedTags: Set<Tag> = []
    
    private var isFormValid: Bool{
        !title.isEmptyOrWhitespace && amount != nil && Double(amount!) > 0 && !selectedTags.isEmpty
    }
    private var total:Double {
        return expenses.reduce(0){result,expense in
            expense.amount + result
            
        }
    }
    private var remaining: Double{
        budget.limit - total
    }
    private func addExpense(){
        let expense = Expense(context: context)
        expense.title = title
        expense.amount = amount ?? 0
        expense.dateCreated = Date()
        expense.tags = NSSet(array: Array(selectedTags))
        budget.addToExpense(expense)
        do{
            try context.save()
            title = ""
            amount = nil
        }catch{
            errorMessage = "Unable to save the expense."
        }
        
    }
    private func deleteExpense(indexSet: IndexSet){
        indexSet.forEach { index in
            let expense = expenses[index]
            context.delete(expense)
        }
        do{
            try context.save()
            
        }catch{
            print(error.localizedDescription)
        }
    }
    var body: some View {
        
        NavigationStack {
            VStack {
                HStack {
                    Text("Total Budget:")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(budget.limit, format: .currency(code: Locale.currencyCode))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
                .padding()
                .background(
                    Color.blue.opacity(0.1) 
                )
                .cornerRadius(10)
                .padding(.horizontal)
            }

            Form{
                Section("New Expenses"){
                    TextField("Title", text: $title)
                    TextField("Amount",value: $amount,format: .number)
                    
                    TagsView(selectedTags: $selectedTags)
                    
                    Button(action: {
                        addExpense()
                    }, label: {
                        Text("Save")
                            .frame(maxWidth: .infinity)
                    }).buttonStyle(.borderedProminent)
                        .disabled(!isFormValid)
                }//.listRowBackground(Color.blue.opacity(0.1))

                Section("Expenses"){
                    List{
                        ForEach(expenses){expense in
                            ExpenseCellView(expense: expense)
                            
                        }.onDelete(perform: { indexSet in
                            deleteExpense(indexSet: indexSet)

                        })
                        VStack{
                            HStack {
                                Spacer()
                                Text("Total Expenses")
                                Text(total,format: .currency(code: Locale.currencyCode))
                                Spacer()
                            }
                            HStack {
                                Spacer()
                                Text("Remaining Budget")
                                Text(remaining,format: .currency(code: Locale.currencyCode))
                                    .foregroundStyle(remaining < 0 ? .red : .green)
                                Spacer()
                            }
                        }
                    }
                    
                }
                
            }
            .navigationTitle(budget.title ?? "")
            
        }
    }
}

struct BudgetDetailScreenContainer:View {
    @FetchRequest(sortDescriptors: []) private var budgets: FetchedResults<Budget>
    var body: some View {
        BudgetDetailScreen(budget: budgets.first(where: {$0.title == "Vegs"})!)
    }
}

#Preview {
    NavigationStack{
        BudgetDetailScreenContainer()
            .environment(\.managedObjectContext, CoreDataProvider.preview.context)
    }
    
}

