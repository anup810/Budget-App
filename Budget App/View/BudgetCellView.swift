//
//  BudgetCellView.swift
//  Budget App
//
//  Created by Anup Saud on 2024-09-11.
//

import SwiftUI

struct BudgetCellView: View {
    @Environment(\.managedObjectContext) private var context
    let budget : Budget
    var body: some View {
        HStack {
            Text(budget.title ?? "")
            Spacer()
            Text(budget.limit, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
        }
    }
}


    #Preview {
        // Use the dummy data from CoreDataProvider.preview
        let context = CoreDataProvider.preview.context
        let budgets = try? context.fetch(Budget.fetchRequest()) as? [Budget]
        
        // Pass the first dummy budget to the preview if available
        return BudgetCellView(budget: budgets?.first ?? Budget(context: context))
}

