//
//  PickerWithCarView.swift
//  AutoInsight
//
//  Created by Quercy on 07.08.2024.
//

import SwiftUI

struct PickerWithCarView: View {
    
    var searchText:String
    @Binding var selectedValue: String
    var filteredModels: [String]
    var shortCategoryName: String
    
    @State private var imageIndex: Int = 0
    let images = ["RedCar", "Orange", "Yellow", "LightBlue", "Blue"]
    
    
    
    var body: some View {
        
        Picker("Select Model", selection: $selectedValue) {
            
            // Show any model
            HStack {
                Text("Any \(shortCategoryName)")
                if selectedValue.isEmpty {
                    Image(images[imageIndex])
                        .resizable()
                        .scaledToFit()
                }
            }
            .tag("")
            
            // Show model fetched from API
            ForEach(Array(Set(filteredModels)).sorted(), id: \.self) { model in
                if model != selectedValue {
                    Text(model).tag(model)
                } else {
                    HStack {
                        Text(model).tag(model)
                            Image(images[imageIndex])
                                .resizable()
                                .scaledToFit()
                    }
                }
            }
        }
        .pickerStyle(.inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            if !isMacOS() {
                startImageTimer()
            }
        }
        
        Text("Selected: \(selectedValue)")
            .padding()
    }
    
    // Timer that change images in picker
    
    func startImageTimer() {
        Timer.scheduledTimer(withTimeInterval: 0.75, repeats: true) { timer in
            imageIndex = (imageIndex + 1) % images.count
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
    PickerWithCarView(searchText: "", selectedValue: .constant(""), filteredModels: ["190E", "230E", "S63"], shortCategoryName: "model")
}
