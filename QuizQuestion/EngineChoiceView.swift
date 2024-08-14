//
//  EngineChoiceView.swift
//  AutoInsight
//
//  Created by Quercy on 03.08.2024.
//

import SwiftUI

struct EngineChoiceView: View {
    var combustionTypes = ["Regular", "Premium", "Diesel"]
    var electricType = "Electricity"
    var randomNumber = Int.random(in: 0...2)
    
    @State private var isTapped = false
    
    @Binding var selectedFuel:String
    @Binding var selectedYear:String
    @Binding var selectedManufacturer:String
    
    @Environment(\.locale) var locale
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                // Combustion engine
                Button(action: {
                    isTapped = true
                    selectedFuel = combustionTypes[randomNumber]
                    
                }) {
                    HStack {
                        Image(systemName: "engine.combustion.fill")
                            .resizable()
                            .frame(width: 70, height: 50)
                            .foregroundColor(.white)
                            .symbolRenderingMode(.multicolor)
                            .symbolEffect(.pulse)
                        Text("Diesel or Petrol engine")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.blue)
                    
                }

                .sensoryFeedback(.success, trigger: isTapped)
                
                
                
                // Electric engine
                Button(action: {
                    isTapped = true
                    selectedFuel = electricType
                }) {
                    HStack {
                        Image(systemName: "bolt.car.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 60)
                            .foregroundColor(.white)
                            .symbolRenderingMode(.multicolor)
                            .symbolEffect(.pulse)
                        Text("Electric engine")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(red: 0.000, green: 0.502, blue: 0.251))
                }
                
                .sensoryFeedback(.success, trigger: isTapped)
                
            }
            .edgesIgnoringSafeArea(.all)
        }
        .navigationDestination(isPresented: $isTapped) {
            AgeChoiceView(selectedFuel: $selectedFuel, selectedYear: $selectedYear, selectedManufacturer: $selectedManufacturer)
                .environment(\.locale, locale)
        }
    }
    
}

#Preview {
    EngineChoiceView(selectedFuel: .constant(""), selectedYear: .constant(""), selectedManufacturer: .constant(""))
}
