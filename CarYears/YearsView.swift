//
//  YearsViewModel.swift
//  AutoInsight
//
//  Created by Quercy on 17.07.2024.
//

import SwiftUI

struct YearsView: View {
    @StateObject private var viewModel = YearsViewModel()
    @State private var searchText = ""
    @State private var years: [String] = []
    @State private var isLoading = true
    
    @Binding var selectedManufacturer: String
    @Binding var selectedModel: String
    @Binding var selectedYear: String
    
    var filteredYears: [String] {
        if searchText.isEmpty {
            return viewModel.modelYears
        } else {
            return viewModel.modelYears.filter { $0.localizedCaseInsensitiveContains(searchText)}
        }
    }

    var body: some View {
        VStack {
            if isLoading {
                LoadingScreenView()
                    .transition(.opacity)
            } else {
                NavigationStack {
                    if !isMacOS() {
                        SwipeDownText()
                    }
                    
                    Header(text: "Pick a year", subtext: "Swipe down to close the menu")
                    
                    VStack {
                        TextField("Search year...", text: $searchText)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                        
                    PickerWithCarView(searchText: searchText, selectedValue: $selectedYear, filteredModels: filteredYears, shortCategoryName: "year")
                    }
                }
                .transition(.opacity)
            }
        }
        .onAppear {
            viewModel.fetchVehicleYears(make: selectedManufacturer, model: selectedModel) {
                withAnimation(.easeInOut) {
                    isLoading = false
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
    YearsView(selectedManufacturer: .constant("BMW"), selectedModel: .constant("M3"), selectedYear: .constant(""))
}



