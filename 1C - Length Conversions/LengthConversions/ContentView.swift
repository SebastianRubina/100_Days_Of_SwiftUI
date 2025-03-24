//
//  ContentView.swift
//  LengthConversions
//
//  Created by Sebastián Rubina on 2025-03-23.
//

import SwiftUI

struct ContentView: View {
    let lengthUnits = ["Meters", "Km", "Feet", "Yards", "Miles"]
    
    @State private var amount = 100.0
    @State private var fromUnit = "Meters"
    @State private var toUnit = "Km"
    @FocusState private var amountIsFocused: Bool
    
    private var convertedAmount: Double {
        var amountInMeters = 0.0
        switch fromUnit {
        case "Km":
            amountInMeters = amount * 1000
        case "Feet":
            amountInMeters = amount * 0.3048
        case "Yards":
            amountInMeters = amount * 0.9144
        case "Miles":
            amountInMeters = amount * 1609.344
        default:
            amountInMeters = amount
        }
        
        var result = 0.0
        switch toUnit {
        case "Km":
            result = amountInMeters / 1000
        case "Feet":
            result = amountInMeters / 0.3048
        case "Yards":
            result = amountInMeters / 0.9144
        case "Miles":
            result = amountInMeters * 0.00062137119
        default:
            result = amountInMeters
        }
        
        return result
    }

    
    var body: some View {
        NavigationStack {
            Form {
                Section("Amount") {
                    TextField("Amount", value: $amount, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
                
                Section("From") {
                    Picker("From Unit", selection: $fromUnit) {
                        ForEach(lengthUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("To") {
                    Picker("To Unit", selection: $toUnit) {
                        ForEach(lengthUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Result") {
                    Text(convertedAmount.formatted())
                }
            }
            .navigationTitle("Length Conversions")
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
