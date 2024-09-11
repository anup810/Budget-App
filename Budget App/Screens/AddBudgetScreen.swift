//
//  AddBudgetScreen.swift
//  Budget App
//
//  Created by Anup Saud on 2024-09-11.
//

import SwiftUI

struct AddBudgetScreen: View {
    @Environment(\.managedObjectContext) private var context
    @State private var title:String = ""
   @State private var limit:Double?
    @State private var errorMessage:String = ""
    
    private var isFormValid: Bool{
        !title.isEmptyOrWhitespace && limit != nil && Double(limit!) > 0
    }
    
    func saveBudget(){
        let budget = Budget(context: context)
        budget.title = title
        budget.limit = limit ?? 0.0
        budget.dateCreated = Date()
        
        do{
            try context.save()
            errorMessage = ""
            title = ""
            limit = nil
        }catch{
            errorMessage = "Unable to save budget."
        }
    }
    
    var body: some View {
        Form{
            Text("New Budget")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(.bold)
            TextField("Title", text: $title)
                .presentationDetents([.medium])
            TextField("Limit", value: $limit, format: .number)
                .keyboardType(.numberPad)
            Button{
                //action
                if !Budget.exits(context: context, title: title){
                    //saveBudget
                   saveBudget()
                }
                else{
                    //error message
                    errorMessage = "Buget title already exits."
                }
            }label: {
                Text("Save")
                    .frame(maxWidth: .infinity)
            }.buttonStyle(.borderedProminent)
                .disabled(!isFormValid)
                //.presentationDetents([.medium])
            Text(errorMessage)
           
        }
    }
}

#Preview {
    AddBudgetScreen()
        .environment(\.managedObjectContext, CoreDataProvider(inMemory: true).context)
}
