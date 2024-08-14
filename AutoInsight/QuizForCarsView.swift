//
//  QuizForCarsView.swift
//  AutoInsight
//
//  Created by Quercy on 03.08.2024.
//

import SwiftUI

struct QuizForCarsView: View {
    
    @State private var selectedManufacturer = ""
    @State private var selectedModel = ""
    @State private var selectedYear = ""
    @State private var selectedFuel = ""
    
    var body: some View {
        Header(text: "Would your car rather have", subtext: "")
            ZStack {
                // First question
                EngineChoiceView(selectedFuel: $selectedFuel, selectedYear: $selectedYear, selectedManufacturer: $selectedManufacturer)
                
                // OR Text in Black Circle
                ORSignView()
            }
        }
    
}

#Preview {
    QuizForCarsView()
}
