//
//  CategoryDetailView.swift
//  AutoInsight
//
//  Created by Quercy on 11.07.2024.
//

import SwiftUI
import Foundation

struct CategoryDetailView: View {
    var category: Category
    @Binding var selectedManufacturer: String
    @Binding var selectedModel: String
    @Binding var selectedYear: String
    @Binding var selectedFuel: String
    
    @State private var selectedValue: String = ""
    
    var FuelTypes = ["Regular", "Premium", "Gasoline or E85", "Diesel", "Electricity", "Premium and Electricity", "Midgrade", "Regular Gas and Electricity", "Hydrogen"]
    
    @Environment(\.locale) var locale
    
    var body: some View {
        NavigationStack {
            VStack {
                
                if category.title == "Manufacturer" {
                    if !isMacOS() {
                        SwipeDownText()
                    }
                    
                    ManufacturersView(selectedManufacturer: $selectedManufacturer, selectedModel: $selectedModel, selectedYear: $selectedYear)
                        .environment(\.locale, locale)
                } else if category.title == "Model name" {
                    
                    
                    ModelsView(selectedModel: $selectedModel, make: $selectedManufacturer, selectedYear: $selectedYear)
                        .environment(\.locale, locale)
                } else if category.title == "Year of production" {
                    
                    YearsView(selectedManufacturer: $selectedManufacturer, selectedModel: $selectedModel, selectedYear: $selectedYear)
                        .environment(\.locale, locale)
                } else if category.title == "Fuel type" {
                    if !isMacOS() {
                        SwipeDownText()
                    }
                    VStack {
                        Header(text: "Fuel types", subtext: "Swipe down to close the menu")
                        PickerWithCarView(searchText: "", selectedValue: $selectedFuel, filteredModels: FuelTypes, shortCategoryName: "fuel type")
                            .environment(\.locale, locale)
                    }
                    .onAppear {
                        selectedFuel = FuelTypes.first ?? ""
                    }
                } else {
                    Text("Work in progress")
                }
            }
        }
    }
    
    // Function to check if running on macOS
    private func isMacOS() -> Bool {
        if ProcessInfo.processInfo.isiOSAppOnMac {
            return true
        } else {
            return false
        }
    }
}

#Preview {
    CategoryDetailView(category: Category(imageName: "Maker", title: "Fuel type", ShortTitle: "fuel"), selectedManufacturer: .constant(""), selectedModel: .constant(""), selectedYear: .constant(""), selectedFuel: .constant(""))
}

