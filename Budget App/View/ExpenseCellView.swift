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
        VStack(alignment:.leading) {
            HStack {
                Text(expense.title ?? "")
                Spacer()
                Text(expense.amount, format: .currency(code: Locale.currencyCode))

            }
            ScrollView(.horizontal){
                HStack{
                    ForEach(Array(expense.tags as? Set<Tag> ?? [])){ tag in
                        Text(tag.name ?? "")
                            .font(.caption)
                            .padding(6)
                            .foregroundStyle(.white)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
                        
                    }
                }
            }
        }
    }
}

struct ExpenseCellContainer: View {
    @FetchRequest(sortDescriptors: []) private var expense : FetchedResults<Expense>
    var body: some View {
        ExpenseCellView(expense: expense[1])
            
    }
}

#Preview {
    ExpenseCellContainer()
        .environment(\.managedObjectContext, CoreDataProvider.preview.context)
}
