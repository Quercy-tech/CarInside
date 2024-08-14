//
//  ModelsView.swift
//  AutoInsight
//
//  Created by Quercy on 16.07.2024.
//

import SwiftUI

struct ModelsView: View {
    @StateObject private var viewModel = VehicleViewModel()
    @State private var searchText = ""
    @State private var isLoading = true
    @State private var savedManufacturer = ""
    
    @Binding var selectedModel: String
    @Binding var make: String
    @Binding var selectedYear: String
    
    @State private var imageIndex: Int = 0
       let images = ["RedCar", "Orange", "Yellow", "LightBlue", "Blue"]
    
    
    var filteredModels: [String] {
        if searchText.isEmpty {
            return viewModel.models
        } else {
            return viewModel.models.filter { $0.localizedCaseInsensitiveContains(searchText)}
        }
    }
    
    var body: some View {
            
            VStack {
                if isLoading { // Check if data is being loaded
                    LoadingScreenView()
                        .transition(.opacity)
                } else {
                    NavigationStack {
                        if !isMacOS() {
                            SwipeDownText()
                        }
                        
                        Header(text: "Select a model", subtext: "Swipe down to close the menu")
                        VStack {
                            TextField("Search model...", text: $searchText)
                                .padding()
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                            
                            PickerWithCarView(searchText: searchText, selectedValue: $selectedModel, filteredModels: filteredModels, shortCategoryName: "model")
                        }
                        .transition(.opacity)
                    }
                }
            }
            .onAppear {
                savedManufacturer = make
                fetchModels()
            }
            .onChange(of: selectedModel) {
                selectedYear = ""
                let selectionFeedback = UIImpactFeedbackGenerator(style: .heavy)
                selectionFeedback.impactOccurred()
                make = savedManufacturer
            }
            .onChange(of: searchText) {
                selectedModel = filteredModels.sorted().first ?? ""
            }
        
    }
    
    // Get models from API
    
    private func fetchModels() {
        isLoading = true
        viewModel.fetchVehicleModels(make: make) {
            withAnimation(.easeInOut) {
                isLoading = false
            }
        }
    }
    
    // Function to check if running on macOS
    private func isMacOS() -> Bool {
        ProcessInfo.processInfo.isiOSAppOnMac
    }
}

#Preview {
    ModelsView(selectedModel: .constant(""), make: .constant("Mercedes-Benz"), selectedYear: .constant(""))
}


