//
//  ContentView.swift
//  WeSplit
//
//  Created by Mohamed Obaya on 23/04/2025.
//

import SwiftUI

struct ContentView: View {
    @State var checkAmount = 0.0
    @State var numberOfPeople = 2
    @State var tipPercentage = 20
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    @FocusState var isCheckAmountFocused: Bool
    
    var checkAmountWithTip: Double {
        checkAmount * (1 + (Double(tipPercentage) / 100))
    }
    
    var checkAmountPerPerson: Double {
        checkAmountWithTip / Double(numberOfPeople + 2)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($isCheckAmountFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section("tip percentage"){
                    Picker("Tip Percentages", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Total Amount per person") {
                    Text(checkAmountPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Total amount \(tipPercentage == 0 ? "": "with tips")") {
                    Text(checkAmountWithTip, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if isCheckAmountFocused {
                    Button("Done") {
                        isCheckAmountFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
