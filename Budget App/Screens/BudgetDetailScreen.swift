//
//  BudgetDetailScreen.swift
//  Budget App
//
//  Created by Anup Saud on 2024-09-11.
//

import SwiftUI

struct BudgetDetailScreen: View {
    @Environment(\.managedObjectContext) private var context
    let budget: Budget
    @State private var title: String = ""
    @State private var amount:Double?
    @State private var errorMessage = ""
    private var isFormValid: Bool{
        !title.isEmptyOrWhitespace && amount != nil && Double(amount!) > 0
    }
    private func addExpense(){
        let expense = Expense(context: context)
        expense.title = title
        expense.amount = amount ?? 0.0
        budget.addToExpense(expense)
        do{
            try context.save()
            title = ""
            amount = nil
        }catch{
            errorMessage = "Unable to save the expense."
        }
        
    }
    var body: some View {
        
        NavigationStack {
            Form{
                Section("New Expenses"){
                    TextField("Title", text: $title)
                    TextField("Amount",value: $amount,format: .number)
                    Button(action: {
                        addExpense()
                    }, label: {
                        Text("Save")
                            .frame(maxWidth: .infinity)
                    }).buttonStyle(.borderedProminent)
                        .disabled(!isFormValid)
                }
                
            }.navigationTitle(budget.title ?? "")
        }
    }
}

struct BudgetDetailScreenContainer:View {
    @FetchRequest(sortDescriptors: []) private var budgets: FetchedResults<Budget>
    var body: some View {
        BudgetDetailScreen(budget: budgets[0])
    }
}

#Preview {
    NavigationStack{
        BudgetDetailScreenContainer()
            .environment(\.managedObjectContext, CoreDataProvider.preview.context)
    }
    
}
