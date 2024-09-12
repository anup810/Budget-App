//
//  BudgetListScreen.swift
//  Budget App
//
//  Created by Anup Saud on 2024-09-11.
//

import SwiftUI

struct BudgetListScreen: View {
    @State private var isPresented: Bool = false
    @FetchRequest(sortDescriptors: []) private var budgets : FetchedResults<Budget>
    var body: some View {
        NavigationStack{
            VStack{
                List(budgets){budget in
                    NavigationLink {
                        BudgetDetailScreen(budget: budget)
                    } label: {
                        BudgetCellView(budget: budget)
                    }
                    
                }
            }.navigationTitle("Budget App")
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add Budget"){
                            isPresented = true
                        }
                    }
                }.sheet(isPresented: $isPresented) {
                    AddBudgetScreen()
                        .presentationDetents([.medium])
                }
        }
    }
}

#Preview {
    NavigationStack{
        BudgetListScreen()
    }.environment(\.managedObjectContext, CoreDataProvider.preview.context)
}

