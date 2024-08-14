//
//  AgeChoiceView.swift
//  AutoInsight
//
//  Created by Quercy on 03.08.2024.
//

import SwiftUI

struct AgeChoiceView: View {
    var oldCombustionAges = Array(1985...2000)
    var oldElectricAges = Array(2012...2017)
    var newCombustionAges = Array(2001...2024)
    var newElectricAges = Array(2018...2024)
    @State private var randomNumber = 0
    @State private var isTapped = false
    
    @Binding var selectedFuel:String
    @Binding var selectedYear:String
    @Binding var selectedManufacturer:String
    
    @Environment(\.locale) var locale
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    
                    
                    // Old car option
                    Button(action: {
                        isTapped = true
                        
                        // old combustion car
                        if selectedFuel != "Electricity" {
                            randomNumber = Int.random(in: 0..<oldCombustionAges.count)
                            selectedYear = String(oldCombustionAges[randomNumber])
                            
                        } else {
                            // old electric car
                            randomNumber = Int.random(in: 0..<oldElectricAges.count)
                            selectedYear = String(oldElectricAges[randomNumber])
                        }
                        
                    }) {
                        HStack {
                            Image(systemName: "arrowshape.turn.up.backward.badge.clock.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .symbolRenderingMode(.multicolor)
                                .symbolEffect(.variableColor)
                                .foregroundColor(.white)
                            Text("Old car")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.blue)
                        
                    }
                    .buttonStyle(PlainButtonStyle())
                    .sensoryFeedback(.success, trigger: isTapped)
                    
                    
                    // New car option
                    Button(action: {
                        isTapped = true
                        
                        // new combustion car
                        if selectedFuel != "Electricity" {
                            randomNumber = Int.random(in: 0..<newCombustionAges.count)
                            selectedYear = String(newCombustionAges[randomNumber])
                            
                        } else {
                            // new electric car
                            randomNumber = Int.random(in: 0..<newElectricAges.count)
                            selectedYear = String(newElectricAges[randomNumber])
                        }
                        
                    }) {
                        HStack {
                            Image(systemName: "arrowshape.right.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.white)
                                .symbolEffect(.variableColor)
                            Text("New car")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(red: 0.945, green: 0.094, blue: 0.298))
                    }
                    
                    .buttonStyle(PlainButtonStyle())
                    .sensoryFeedback(.success, trigger: isTapped)
                    
                }
                .edgesIgnoringSafeArea(.all)
                
                // OR Circle
                VStack {
                    Spacer()
                    ZStack {
                        Circle()
                            .frame(width: 90)
                            .foregroundColor(.black)
                        Text("OR")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 16)
                    Spacer()
                }
                
            }
            .navigationDestination(isPresented: $isTapped) {
                CountryChoiceView(selectedFuel: $selectedFuel, selectedYear: $selectedYear, selectedManufacturer: $selectedManufacturer)
                    .environment(\.locale, locale)
            }
        }
    }
}

#Preview {
    AgeChoiceView(selectedFuel: .constant(""), selectedYear: .constant(""), selectedManufacturer: .constant(""))
}
