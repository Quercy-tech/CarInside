//
//  CategoriesView.swift
//  AutoInsight
//
//  Created by Quercy on 11.07.2024.
//

import SwiftUI

struct CategoriesView: View {
    
    @State private var selectedCategory: Category?
    @State private var selectedManufacturer = ""
    @State private var selectedModel = ""
    @State private var selectedYear = ""
    @State private var selectedFuel = ""
    
    @State private var showConfiguration = false
    @State private var showDetailView = false
    
    @Environment(\.locale) var locale
    
    // Dictionary to map category titles to state variables
    private var selectedValues: [String: Binding<String>] {
        [
            String(describing: LocalizedStringKey("Manufacturer")): $selectedManufacturer,
            String(describing: LocalizedStringKey("Model name")): $selectedModel,
            String(describing: LocalizedStringKey("Fuel type")): $selectedFuel,
            String(describing: LocalizedStringKey("Year of production")): $selectedYear
        ]
    }


    var body: some View {
        NavigationStack {
            VStack {
                Header(text: "Choose what type of car you want", subtext: "Tap on the buttons to select car's brand model etc.")
                categoriesGrid
                exploreButton
            }
            .sheet(item: $selectedCategory) { category in
                CategoryDetailView(category: category, selectedManufacturer: $selectedManufacturer, selectedModel: $selectedModel, selectedYear: $selectedYear, selectedFuel: $selectedFuel)
                    .environment(\.locale, locale)
            }
        }
        .navigationDestination(isPresented: $showConfiguration) {
            ContentView(make: selectedManufacturer, model: selectedModel, year: selectedYear, fuel: selectedFuel)
                .environment(\.locale, locale)
        }
    }
    
    private var categoriesGrid: some View {
        GeometryReader { geometry in
            let isCompact = geometry.size.width < 600
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(Categories) { category in
                        VStack {
                            Image(category.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: isCompact ? 175 : geometry.size.width / 3, height: isCompact ? 110 : geometry.size.height / 4)
                                .clipped()
                                .cornerRadius(15)
                            VStack {
                                Text(category.title)
                                    .font(.system(size: 20))
                                Text(displaySelectedValues(for: category.title, short: category.ShortTitle))
                                    .font(.system(size: 15))
                                    .foregroundStyle(.secondary)
                            }
                            .frame(width: isCompact ? 175 : geometry.size.width / 3, height: isCompact ? 110 : geometry.size.height / 4)
                            .background(Color.black.opacity(0.75))
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white.opacity(0.3), lineWidth: 1))
                        }
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 5)
                        .padding(5)
                        .onTapGesture {
                            selectedCategory = category
                            showDetailView = true
                        }
                    }
                }
            }
        }
    }
    
    private var exploreButton: some View {
        Button(action: {
                showConfiguration = true
            
        }) {
            Text("Explore cars")
                .bold()
                .foregroundColor(.white)
                .frame(width: 200, height: 50)
                .background(Color.blue)
                .cornerRadius(10)
                .padding()
            
        }
        .sensoryFeedback(.success, trigger: showConfiguration)
    }
    
    // Display selected values
    private func displaySelectedValues(for categoryTitle: LocalizedStringKey, short shortTitle: LocalizedStringKey) -> LocalizedStringKey {
        if let binding = selectedValues[String(describing: categoryTitle)], !binding.wrappedValue.isEmpty {
            return "Selected: \(binding.wrappedValue)"
        } else {
            return "Any"
        }
    }

}

struct Category: Identifiable {
    let id = UUID()
    let imageName: String
    let title: LocalizedStringKey
    let ShortTitle: LocalizedStringKey
}

let Categories = [
    Category(imageName: "Maker", title: LocalizedStringKey("Manufacturer"), ShortTitle: LocalizedStringKey("manufacturer")),
    Category(imageName: "Model", title: LocalizedStringKey("Model name"), ShortTitle: LocalizedStringKey("model")),
    Category(imageName: "Fuel2", title: LocalizedStringKey("Fuel type"), ShortTitle: LocalizedStringKey("fuel")),
    Category(imageName: "Years", title: LocalizedStringKey("Year of production"), ShortTitle: LocalizedStringKey("year"))
]


#Preview("English") {
    CategoriesView()
}

#Preview("Ukranian") {
    CategoriesView()
        .environment(\.locale, Locale(identifier: "Uk"))
}

#Preview("Russian") {
    CategoriesView()
        .environment(\.locale, Locale(identifier: "ru"))
}
