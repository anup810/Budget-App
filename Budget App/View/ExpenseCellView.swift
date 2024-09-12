//
//  ExpenseCellView.swift
//  Budget App
//
//  Created by Anup Saud on 2024-09-11.
//

import SwiftUI

struct ExpenseCellView: View {
    let expense: Expense
    var body: some View {
        HStack {
            Text(expense.title ?? "")
            Spacer()
            Text(expense.amount, format: .currency(code: Locale.currencyCode))
        }
    }
}

struct ExpenseCellContainer: View {
    @FetchRequest(sortDescriptors: []) private var expense : FetchedResults<Expense>
    var body: some View {
        ExpenseCellView(expense: expense[0])
    }
}

#Preview {
    ExpenseCellContainer()
        .environment(\.managedObjectContext, CoreDataProvider.preview.context)
}
