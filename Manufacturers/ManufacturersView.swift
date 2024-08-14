//
//  GetAllCompaniesView.swift
//  AutoInsight
//
//  Created by Quercy on 12.07.2024.
//

import SwiftUI

struct ManufacturersView: View {
    @State private var searchText = ""
    @Binding var selectedManufacturer: String
    @Binding var selectedModel: String
    @Binding var selectedYear: String
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return CarManufacturersList.manufacturers
        } else {
            return CarManufacturersList.manufacturers.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationStack {
            
            Header(text: "Car manufacturers", subtext: "Swipe down to close the menu")
            
            VStack {
                TextField("Search model...", text: $searchText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                
                PickerWithCarView(searchText: searchText, selectedValue: $selectedManufacturer, filteredModels: searchResults, shortCategoryName: "manufacturer")
                .onChange(of: selectedManufacturer) {
                    selectedModel = ""
                    selectedYear = ""
                    let selectionFeedback = UIImpactFeedbackGenerator(style: .heavy)
                    selectionFeedback.impactOccurred()
                    }
                .onChange(of: searchText) {
                    selectedManufacturer = searchResults.sorted().first ?? ""
                }
            }
        }
    }
  
}

// Preview
#Preview {
    ManufacturersView(selectedManufacturer: .constant(""), selectedModel: .constant(""), selectedYear: .constant(""))
}




