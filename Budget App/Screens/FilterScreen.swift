//
//  FilterScreen.swift
//  Budget App
//
//  Created by Anup Saud on 2024-09-13.
//

import SwiftUI

struct FilterScreen: View {
    
    @Environment(\.managedObjectContext) private var context
    @State private var selectedTags: Set<Tag> = []
    
    @FetchRequest(sortDescriptors: []) private var expenses: FetchedResults<Expense>
    @State private var filteredExpenses: [Expense] = []
    
    @State private var startPrice: Double?
    @State private var endPrice: Double?
    
    @State private var title: String = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    private func filterTags() {
        
        if selectedTags.isEmpty {
            return
        }
        
        let selectedTagNames = selectedTags.map { $0.name }
        
        let request = Expense.fetchRequest()
        request.predicate = NSPredicate(format: "ANY tags.name IN %@", selectedTagNames)
        
        do {
            filteredExpenses = try context.fetch(request)
        } catch {
            print(error)
        }
    }
    
    private func filterByPrice() {
        
        guard let startPrice = startPrice,
              let endPrice = endPrice else { return }
        
        let request = Expense.fetchRequest()
        request.predicate = NSPredicate(format: "amount >= %@ AND amount <= %@", NSNumber(value: startPrice), NSNumber(value: endPrice))
        
        do {
            filteredExpenses = try context.fetch(request)
        } catch {
            print(error)
        }
        
    }
    
    private func filterByTitle() {
        
        let request = Expense.fetchRequest()
        request.predicate = NSPredicate(format: "title BEGINSWITH %@", title)
        
        do {
            filteredExpenses = try context.fetch(request)
        } catch {
            print(error)
        }
    }
    private func filterByDate() {
        
        let request = Expense.fetchRequest()
        request.predicate = NSPredicate(format: "dateCreated >= %@ AND dateCreated <= %@", startDate as NSDate, endDate as NSDate)
        
        do {
             filteredExpenses = try context.fetch(request)
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        List {
            
            Section("Filter by Tags") {
                TagsView(selectedTags: $selectedTags)
                    .onChange(of: selectedTags, filterTags)
            }
            
            Section("Filter by Price") {
                TextField("Start price", value: $startPrice, format: .number)
                TextField("End price", value: $endPrice, format: .number)
                Button("Search") {
                    filterByPrice()
                }
            }
            
            Section("Filter by title") {
                TextField("Title", text: $title)
                Button("Search") {
                    filterByTitle()
                }
            }
            Section("Filter by date") {
                DatePicker("Start date", selection: $startDate, displayedComponents: .date)
                DatePicker("End date", selection: $endDate, displayedComponents: .date)
                
                Button("Search") {
                    filterByDate()
                }
            }
            
        
            ForEach(filteredExpenses) { expense in
                ExpenseCellView(expense: expense)
            }
            
            Spacer()
            
            HStack {
                Spacer()
                Button("Show All") {
                    selectedTags = []
                    filteredExpenses = expenses.map { $0 }
                }
                Spacer()
            }
            
        }
        .padding()
        .navigationTitle("Filter")
    }
}

#Preview {
    NavigationStack {
        FilterScreen()
            .environment(\.managedObjectContext, CoreDataProvider.preview.context)
    }
}
