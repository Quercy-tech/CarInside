//
//  BackBarView.swift
//  AutoInsight
//
//  Created by Quercy on 05.08.2024.
//

import SwiftUI

struct BackBarView: View {
    
    @Binding var selectedFuel:String
    @Binding var selectedYear:String
    @Binding var selectedMake:String
    
    @Environment(\.locale) var locale
    
    var body: some View {
        HStack {
            NavigationLink(destination: StartMenu()
                .environment(\.locale, locale)
            ) {
                Image(systemName: "house")
                    .symbolRenderingMode(.multicolor)
                    .symbolEffect(.variableColor)
                    .font(.title)
                    .foregroundColor(.blue)
                    .padding()
            }
            
            Spacer()

            NavigationLink(destination: EngineChoiceView(selectedFuel: $selectedFuel, selectedYear: $selectedYear, selectedManufacturer: $selectedMake)
                .environment(\.locale, locale)
            ) {
                Image(systemName: "arrow.counterclockwise")
                    .symbolRenderingMode(.multicolor)
                    .symbolEffect(.variableColor)
                    .font(.title)
                    .foregroundColor(.blue)
                    .padding()
            }
        }
    }
}

#Preview {
    BackBarView(selectedFuel: .constant("Premium"), selectedYear: .constant("1997"), selectedMake: .constant("Lotus"))
}
