//
//  BudgetCellView.swift
//  Budget App
//
//  Created by Anup Saud on 2024-09-11.
//

import SwiftUI

struct BudgetCellView: View {
    let budget : Budget
    var body: some View {
        HStack {
            Text(budget.title ?? "")
            Spacer()
            Text(budget.limit, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
        }
    }
}

struct BudgetCellViewContainer: View{
    @FetchRequest(sortDescriptors: []) private var budgets: FetchedResults<Budget>
    var body: some View{
        BudgetCellView(budget: budgets[0])
    }
}
#Preview {
  BudgetCellViewContainer()
        .environment(\.managedObjectContext,CoreDataProvider.preview.context)
    
}

