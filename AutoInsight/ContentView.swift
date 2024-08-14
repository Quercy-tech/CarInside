//
//  ContentView.swift
//  AutoInsight
//
//  Created by Quercy on 10.07.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var carSpecificationsViewModel = CarSpecificationsViewModel()
    @State private var isLoading = true
    @State private var selectedTab = 0
    
    @State private var showWebView = false
    @State private var webViewUrl: URL?

    let make: String
    let model: String
    let year: String
    let fuel: String
    
    @State private var gradientColors: [(Color, Color)] = []

    var body: some View {
        NavigationStack {
            if isLoading {
                LoadingScreenView()
                    .transition(.opacity)
            } else if carSpecificationsViewModel.cars.isEmpty {
                NoCarFoundView()
            } else {
                GeometryReader { geometry in
                    let isCompact = geometry.size.width < 600
                    VStack {
                        Header(text: "Car specifications", subtext: "")
                        
                        TabView(selection: $selectedTab) {
                            ForEach(carSpecificationsViewModel.cars.indices, id: \.self) { index in
                                let car = carSpecificationsViewModel.cars[index]
                                let colors: (Color, Color) = index < gradientColors.count ? gradientColors[index] : (.green, .blue)
                                
                                VStack(alignment: .leading, spacing: isCompact ? 5 : 10) {
                                    Text("\(car.make) \(car.model) (\(car.year))")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    
                                    // Show car images via web browser
                                    Text("Car Images:")
                                        .font(isCompact ? .system(size: 17) : .title3)
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                        .padding(3)
                                    
                                    HStack {
                                        if let url = URL(string: "https://www.google.com/search?tbm=isch&q=\(car.make)+\(car.model)+\(car.year)") {
                                            Button("Outside", systemImage: "car.front.waves.down.fill", action: {
                                                webViewUrl = url
                                                showWebView = true
                                            })
                                            .foregroundColor(.white)
                                            .padding(3)
                                            .font(.system(size: 20))
                                            .fontWeight(.bold)
                                        }
                                        
                                        
                                        if let url = URL(string: "https://www.google.com/search?tbm=isch&q=\(car.make)+\(car.model)+\(car.year) interior") {
                                            Button("Inside", systemImage: "carseat.right.fill", action: {
                                                webViewUrl = url
                                                showWebView = true
                                            })
                                            .foregroundColor(.white)
                                            .padding(3)
                                            .font(.system(size: 20))
                                            .fontWeight(.bold)
                                        }
                                    }
                                    // RWD, FWD or AWD, Automatic or Manual
                                    
                                    Text("Drive Type: \(car.drive ?? "Unknown Drive")")
                                        .foregroundColor(.white)
                                        .font(isCompact ? .system(size: 17) : .system(size: 19))
                                    
                                    if let transmission = car.trany {
                                        Text("Transmission: \(transmission)")
                                            .foregroundColor(.white)
                                            .font(isCompact ? .system(size: 17) : .system(size: 19))
                                    }
                                    
                                    // Engine specifications
                                    
                                    if let cylinders = car.cylinders {
                                        Text("Cylinders: \(cylinders)")
                                            .foregroundColor(.white)
                                            .font(isCompact ? .system(size: 17) : .system(size: 19))
                                    }
                                    if let displ = car.displ {
                                        Text("Displacement: \(displ.formatted())L")
                                            .foregroundColor(.white)
                                            .font(isCompact ? .system(size: 17) : .system(size: 19))
                                    }
                                    if let engineDescription = car.eng_dscr {
                                        Text("Engine type: \(engineDescription)")
                                            .foregroundColor(.white)
                                            .font(isCompact ? .system(size: 17) : .system(size: 19))
                                    }
                                    Text("Fuel Type: \(car.fueltype1 ?? "Unknown Fuel Type")")
                                        .foregroundColor(.white)
                                        .font(isCompact ? .system(size: 17) : .system(size: 19))
                                    
                                    // Vehicle size
                                    
                                    Text("Vehicle Class: \(car.vclass ?? "Unknown Class")")
                                        .foregroundColor(.white)
                                        .font(isCompact ? .system(size: 17) : .system(size: 19))
                                    
                                    // Fuel consumption
                                    
                                    if let city08 = car.city08 {
                                        Text("Fuel consumption in city: \(String(format: "%.3f", MPGconversion(mpg: city08)))")
                                            .foregroundColor(.white)
                                            .font(isCompact ? .system(size: 17) : .system(size: 19))
                                    }
                                    if let highway08 = car.highway08 {
                                        Text("Fuel consumption on highway: \(String(format: "%.3f", MPGconversion(mpg: highway08)))")
                                            .foregroundColor(.white)
                                            .font(isCompact ? .system(size: 17) : .system(size: 19))
                                    }
                                
                                    
                                    // How much will you save
                                   
                                    if let yousavespend = car.yousavespend {
                                        Text("You will Save/Spend over 5 years compared to an average car: \(yousavespend)$")
                                            .font(isCompact ? .system(size: 15) : .system(size: 19))
                                            .foregroundColor(.white)
                                    }
                                    
                                    
                                    // Electric motor
                                    
                                    if let evmotor = car.evmotor {
                                        Text("Electric Motor: \(evmotor)")
                                            .foregroundColor(.white)
                                            .font(isCompact ? .system(size: 17) : .system(size: 19))
                                    }
                                    
                                    // Find engine sound on the Youtube
                                    HStack {
                                        if let soundUrl = URL(string: "https://www.google.com/search?tbm=isch&q=\(car.make)+\(car.model)+\(car.year)+exhaust+sound") {
                                            Button(action: {
                                                webViewUrl = soundUrl
                                                showWebView = true
                                            }) {
                                                HStack {
                                                    Text("Engine Sounds")
                                                        .font(isCompact ? .system(size: 15) : .system(size: 20))
                                                        .foregroundColor(.white)
                                                        .fontWeight(.bold)
                                                        .padding(3)
                                                    
                                                    Image(systemName: "horn.blast.fill")
                                                        .foregroundColor(.white)
                                                        .symbolRenderingMode(.multicolor)
                                                        .symbolEffect(.pulse)
                                                    
                                                }
                                            }
                                        }
                                    }
                                    
                                    // Additional specifications
                                    
                                    if car.tcharger != nil {
                                        Text("Turbocharger: T")
                                            .foregroundColor(.white)
                                            .font(isCompact ? .system(size: 17) : .system(size: 19))
                                    }
                                    if car.scharger != nil {
                                        Text("Supercharger: T")
                                            .foregroundColor(.white)
                                            .font(isCompact ? .system(size: 17) : .system(size: 19))
                                    } 
                                }
                                
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [colors.0, colors.1]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                                .cornerRadius(20)
                                .shadow(radius: 10)
                                .padding()
                                .tag(index)
                            }
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                }
                .transition(.opacity)
                .sensoryFeedback(.success, trigger: selectedTab)
            }
        }
        .onAppear {
            carSpecificationsViewModel.fetchCars(make: make, model: model, year: year, fuel: fuel) {
                withAnimation(.easeInOut) {
                    isLoading = false
                    generateGradientColors()
                }
            }
        }
        .navigationDestination(isPresented: $showWebView, destination: {
            if let webViewUrl = webViewUrl {
                WebView(url: webViewUrl)
                    .edgesIgnoringSafeArea(.all)
            }
        })

    }

    // MPG to L/100km
    func MPGconversion(mpg: Int) -> Double {
        return 235.214583 / Double(mpg)
    }
    
    // Generate random colors for each car once
    func generateGradientColors() {
        gradientColors = carSpecificationsViewModel.cars.map { _ in
            (randomColor(), randomColor())
        }
    }
    
    // Generate a random color
    func randomColor() -> Color {
        let colors: [Color] = [
            .red, .orange, .yellow, .green, .blue, .indigo, .purple
        ]
        let randomIndex = Int.random(in: 0..<colors.count)
        return colors[randomIndex]
    }
}

#Preview {
    ContentView(make: "Audi", model: "Q7", year: "2025", fuel: "")
}




