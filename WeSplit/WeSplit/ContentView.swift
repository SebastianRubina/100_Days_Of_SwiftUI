//
//  ContentView.swift
//  WeSplit
//
//  Created by Sebastián Rubina on 2025-03-23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 10
    @FocusState private var amountIsFocused: Bool
    
    private let tipPercentages = [0, 5, 10, 15, 20]
    private var currencyCode = Locale.current.currency?.identifier ?? "USD"
    
    var totalPerPerson: Double {
        let numberOfPeople = Double(numberOfPeople + 2)
        let tipPercentageDouble = Double(tipPercentage)
        
        return (checkAmount + (checkAmount * (tipPercentageDouble / 100.0))) / numberOfPeople
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: currencyCode))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("How much would you like to tip?") {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Total with tip") {
                    Text(checkAmount + (checkAmount * Double(tipPercentage) / 100.0), format: .currency(code: currencyCode))
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: currencyCode))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
