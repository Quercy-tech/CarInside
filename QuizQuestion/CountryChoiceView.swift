//
//  CountryChoiceView.swift
//  AutoInsight
//
//  Created by Quercy on 03.08.2024.
//

import SwiftUI

struct CountryChoiceView: View {
    
    //Europe
    
    let CombustionEuropeanManufacturers = ["BMW", "Audi", "Ferrari", "Volkswagen", "Mercedes-Benz", "Jaguar", "Lamborghini", "Maybach", "BMW", "Mercedes-Benz", "MINI", "Porsche", "Renault", "Rolls-Royce", "Audi", "Volkswagen", "Mercedes-Benz", "Volvo", "Bentley", "Aston Martin", "Alfa Romeo"]
    
    let ElectricEuropeanManufacturers = ["BMW", "smart", "Audi", "Volkswagen", "Mercedes-Benz", "MINI", "Renault", "smart", "Polestar", "smart"]
    
    // USA
    
    let CombustionAmericanManufacturers = ["Cadillac", "Chevrolet", "Chrysler", "Dodge", "Ford", "Hummer", "Jeep", "Plymouth", "Pontiac", "RAM", "Tesla"]
    
    let ElectricAmericanManufacturers = ["Tesla", "Chevrolet", "Tesla", "Rivian", "Lucid", "Tesla"]
    
    ////Asia
    
    let CombustionAsianManufacturers = ["Hyundai", "Infiniti", "Lexus","Kia", "Mazda", "Mitsubishi", "Nissan"]
    
    let ElectricAsianManufacturers = ["Hyundai","Kia", "BYD", "Nissan", "Honda"]
    
    
    @State private var randomNumber = 0
    @State private var isTapped = false
    
    @Binding var selectedFuel:String
    @Binding var selectedYear:String
    @Binding var selectedManufacturer:String
    
    @State var selectedRegionManufacturers:[String] = []
    
    @Environment(\.locale) var locale
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    
                    
                    Button(action: {
                        isTapped = true
                        
                        // European
                        
                        chooseManufacturer(fuel: selectedFuel, combustionManufacturer: CombustionEuropeanManufacturers, electricManufacturer: ElectricEuropeanManufacturers)
                        
                    }) {
                        HStack {
                            Image(systemName: "eurosign.square.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.white)
                                .symbolEffect(.variableColor)
                            Text("European manufacturer")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(red: 1.000, green: 0.573, blue: 0.282))
                        
                    }
                    .sensoryFeedback(.success, trigger: isTapped)
                    
                    Button(action: {
                        isTapped = true
                        
                        // American
                        
                        chooseManufacturer(fuel: selectedFuel, combustionManufacturer: CombustionAmericanManufacturers, electricManufacturer: ElectricAmericanManufacturers)
                            
                    }) {
                        HStack {
                            Image(systemName: "dollarsign.square.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.white)
                                .symbolEffect(.variableColor)
                            Text("North American manufacturer")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(red: 1.000, green: 0.325, blue: 0.286))
                        
                    }
                    .sensoryFeedback(.success, trigger: isTapped)
                    
                    Button(action: {
                        isTapped = true
                        
                        // Asian
                        
                        chooseManufacturer(fuel: selectedFuel, combustionManufacturer: CombustionAsianManufacturers, electricManufacturer: ElectricAsianManufacturers)
                    }) {
                        HStack {
                            Image(systemName: "chineseyuanrenminbisign.square.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.white)
                                .symbolEffect(.variableColor)
                            Text("Asian manufacturer")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(red: 0.278, green: 0.075, blue: 0.216))
                    }
                    
                    .sensoryFeedback(.success, trigger: isTapped)
                    
                }
                .edgesIgnoringSafeArea(.all)
                
                // First OR sign view
                GeometryReader { geometry in
                    VStack {
                        
                        ZStack {
                            Circle()
                                .frame(width: 90)
                                .foregroundColor(.black)
                            Text("OR")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                        }
                        .frame(width: geometry.size.width,height: geometry.size.height / 1.65)
                        
                    }
                    
                    // Second OR sign view
                    
                    VStack {
                        ZStack {
                            Circle()
                                .frame(width: 90)
                                .foregroundColor(.black)
                            Text("OR")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height / 0.73)
                    }
                }
            }
            .navigationDestination(isPresented: $isTapped) {
                
                ResultView(retryChooseManufacturer: chooseManufacturer, selectedManufacturer: selectedRegionManufacturers,
                           selectedFuel: $selectedFuel, selectedYear: $selectedYear, selectedMake: $selectedManufacturer)
                .environment(\.locale, locale)
            }
        }
    }
    
    
    func chooseManufacturer(fuel: String, combustionManufacturer: [String], electricManufacturer: [String]) {
        if fuel != "Electricity" {
            // Combustion
            selectedRegionManufacturers = combustionManufacturer
            randomNumber = Int.random(in: 0..<combustionManufacturer.count)
            selectedManufacturer = String(combustionManufacturer[randomNumber])
            
        } else {
            // Electric
            selectedRegionManufacturers = electricManufacturer
            randomNumber = Int.random(in: 0..<electricManufacturer.count)
            selectedManufacturer = String(electricManufacturer[randomNumber])
        }
    }
    
}

#Preview {
    CountryChoiceView(selectedFuel: .constant(""), selectedYear: .constant(""), selectedManufacturer: .constant(""))
}
