//
//  FilterScreen.swift
//  Budget App
//
//  Created by Anup Saud on 2024-09-13.
//

import SwiftUI

struct FilterScreen: View {
    @Environment(\.managedObjectContext) private var context
    @State private var selectedTags:Set<Tag> = []
    @State private var filteredExpenses: [Expense] = []
    @FetchRequest(sortDescriptors: []) private var expenses : FetchedResults<Expense>
    
    @State private var startPrice: Double?
    @State private var endPrice: Double?
    
    private func filterTags(){
        if selectedTags.isEmpty{
            return
        }
        let selectedTagNames = selectedTags.map{$0.name}
        let request = Expense.fetchRequest()
        request.predicate = NSPredicate(format: "Any tags.name IN %@", selectedTagNames)
        do{
           
           filteredExpenses = try context.fetch(request)
        }catch{
            print(error)
        }
        
    }
    private func filterByPrice(){
        guard let startPrice = startPrice, let endPrice = endPrice else {
            return
        }
        let request = Expense.fetchRequest()
        request.predicate = NSPredicate(format: "amount >= %@ AND amount <= %@", NSNumber(value: startPrice),NSNumber(value: endPrice))
        do{
           
           filteredExpenses = try context.fetch(request)
        }catch{
            print(error)
        }
    }
    var body: some View {
        NavigationStack{
            VStack(alignment:.leading,spacing: 20){
                Section("Filterr by Tags"){
                    TagsView(selectedTags: $selectedTags)
                        .onChange(of: selectedTags,filterTags)
                    List(filteredExpenses){expense in
                        ExpenseCellView(expense: expense)
                
                    }
                    
                }
                Section("Filter by Price") {
                    VStack(alignment: .leading, spacing: 16) {
                        // Start Price
                        Text("Start Price")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        TextField("Enter start price", value: $startPrice, format: .number)
                            .padding(12)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        
                        // End Price
                        Text("End Price")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        TextField("Enter end price", value: $endPrice, format: .number)
                            .padding(12)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        
                        Button(action: {
                            filterByPrice()
                        }) {
                            Text("Search")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.top, 8)
                    }
                }
                Spacer()
                HStack{
                    Spacer()
                    Button("Show All"){
                        selectedTags = []
                        filteredExpenses = expenses.map{$0}
                    }
                    Spacer()
                }
            }.padding()
                .navigationTitle("Filter")
        }
            
    }
}

#Preview {
    NavigationStack{
        FilterScreen()
            .environment(\.managedObjectContext, CoreDataProvider.preview.context)
    }
}
